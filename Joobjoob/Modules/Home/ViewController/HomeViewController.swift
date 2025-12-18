//
//  HomeViewController.swift
//  Joobjoob
//
//  Created by zehye on 12/17/25.
//

import UIKit
import AVFoundation
import CoreML
import Vision

class HomeViewController: UIViewController {

    static func instance() -> HomeViewController {
        UIStoryboard(name: "Home", bundle: nil)
            .instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }

    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!

    private let inputSize: CGFloat = 640   // 🔥 YOLO 입력 사이즈

    private let model: yolo11n = {
        let config = MLModelConfiguration()
        config.computeUnits = .all
        return try! yolo11n(configuration: config)
    }()

    private lazy var visionModel: VNCoreMLModel = {
        try! VNCoreMLModel(for: model.model)
    }()

    // MARK: - YOLO Parsing

    func parseYOLO(
        _ arr: MLMultiArray,
        confThreshold: Float = 0.4
    ) -> [(CGRect, Float)] {

        let boxCount = arr.shape[2].intValue
        var results: [(CGRect, Float)] = []

        for i in 0..<boxCount {

            let cx = arr[[0, 0, i] as [NSNumber]].floatValue
            let cy = arr[[0, 1, i] as [NSNumber]].floatValue
            let w  = arr[[0, 2, i] as [NSNumber]].floatValue
            let h  = arr[[0, 3, i] as [NSNumber]].floatValue

            var maxScore: Float = 0
            for c in 4..<84 {
                let score = arr[[0, c, i] as [NSNumber]].floatValue
                maxScore = max(maxScore, score)
            }

            if maxScore < confThreshold { continue }

            // 🔥 모델 좌표 → 정규화
            let rect = CGRect(
                x: CGFloat((cx - w / 2) / Float(inputSize)),
                y: CGFloat((cy - h / 2) / Float(inputSize)),
                width: CGFloat(w / Float(inputSize)),
                height: CGFloat(h / Float(inputSize))
            )

            results.append((rect, maxScore))
        }

        return results
    }

    // MARK: - Drawing

    func convertToScreen(_ rect: CGRect) -> CGRect {
        CGRect(
            x: rect.origin.x * view.bounds.width,
            y: rect.origin.y * view.bounds.height,
            width: rect.width * view.bounds.width,
            height: rect.height * view.bounds.height
        )
    }

    func draw(_ boxes: [(CGRect, Float)]) {
        DispatchQueue.main.async {

            self.view.layer.sublayers?
                .removeAll { $0.name == "box" }

            for (rect, _) in boxes {
                let layer = CAShapeLayer()
                layer.frame = self.convertToScreen(rect)
                layer.borderWidth = 2
                layer.borderColor = UIColor.red.cgColor
                layer.name = "box"
                self.view.layer.addSublayer(layer)
            }
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
}

// MARK: - Camera Setup

extension HomeViewController {

    private func setupCamera() {
        session.beginConfiguration()
        session.sessionPreset = .high

        let device = AVCaptureDevice.default(for: .video)!
        let input = try! AVCaptureDeviceInput(device: device)

        if session.canAddInput(input) {
            session.addInput(input)
        }

        let output = AVCaptureVideoDataOutput()
        output.alwaysDiscardsLateVideoFrames = true
        output.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String:
                Int(kCVPixelFormatType_32BGRA)
        ]

        let queue = DispatchQueue(label: "camera.queue")
        output.setSampleBufferDelegate(self, queue: queue)

        if session.canAddOutput(output) {
            session.addOutput(output)
        }

        output.connection(with: .video)?.videoOrientation = .portrait

        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill

        // 🔥 preview는 제일 뒤
        view.layer.insertSublayer(previewLayer, at: 0)

        session.commitConfiguration()
    }
}

// MARK: - Camera Delegate

extension HomeViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {

        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }

        let request = VNCoreMLRequest(model: visionModel) { request, error in
            if let error = error {
                print("❌ Vision error:", error)
                return
            }

            guard
                let obs = request.results?.first as? VNCoreMLFeatureValueObservation,
                let arr = obs.featureValue.multiArrayValue
            else { return }

            let boxes = self.parseYOLO(arr)
            print("🔥 boxes:", boxes.count)
            self.draw(boxes)
        }

        request.imageCropAndScaleOption = .scaleFill

        let handler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            orientation: .up,
            options: [:]
        )

        try? handler.perform([request])
    }
}
