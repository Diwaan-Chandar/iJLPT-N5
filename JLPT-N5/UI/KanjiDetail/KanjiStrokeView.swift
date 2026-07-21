//
//  KanjiStrokeView.swift
//  JLPT-N5
//

import SwiftUI

struct KanjiStrokeView: View {
    let strokes: [String]
    
    @State private var strokeProgresses: [CGFloat]
    @State private var playTask: Task<Void, Never>?
    
    private let strokePaths: [Path]
    private let viewBoxSize: CGFloat = 109.0
    
    init(strokes: [String]) {
        self.strokes = strokes
        self.strokePaths = strokes.map { SVGPathParser.parse($0) }
        _strokeProgresses = State(initialValue: Array(repeating: 0.0, count: strokes.count))
    }
    
    var body: some View {
        VStack(spacing: 24) {
            GeometryReader { geometry in
                let dimension = min(geometry.size.width, geometry.size.height)
                let scale = dimension / viewBoxSize
                let offsetX = (geometry.size.width - dimension) / 2
                let offsetY = (geometry.size.height - dimension) / 2
                
                ZStack {
                    // Background guide paths
                    ForEach(0..<strokePaths.count, id: \.self) { index in
                        strokePaths[index]
                            .scaledAndOffset(scale: scale, dx: offsetX, dy: offsetY)
                            .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                    }
                    
                    // Animated foreground paths
                    ForEach(0..<strokePaths.count, id: \.self) { index in
                        strokePaths[index]
                            .scaledAndOffset(scale: scale, dx: offsetX, dy: offsetY)
                            .trim(from: 0, to: strokeProgresses[index])
                            .stroke(Color.primary, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                    }
                }
            }
            .frame(height: 160) // Slightly larger container for better visibility
            .padding(.horizontal)
            .contentShape(Rectangle())
            .onTapGesture {
                playAnimation()
            }
        }
        .onAppear {
            playAnimation()
        }
        .onDisappear {
            playTask?.cancel()
        }
    }
    
    private func playAnimation() {
        playTask?.cancel()
        
        // Reset all progresses immediately
        for i in 0..<strokeProgresses.count {
            strokeProgresses[i] = 0.0
        }
        
        playTask = Task { @MainActor in
            // Small delay before starting playback
            try? await Task.sleep(nanoseconds: 200_000_000)
            
            for i in 0..<strokePaths.count {
                if Task.isCancelled { break }
                
                withAnimation(.linear(duration: 0.4)) {
                    strokeProgresses[i] = 1.0
                }
                
                // Wait for the animation of this stroke to finish
                try? await Task.sleep(nanoseconds: 400_000_000)
            }
        }
    }
}

// Extension to help with Path offset and transform
extension Path {
    func scaledAndOffset(scale: CGFloat, dx: CGFloat, dy: CGFloat) -> Path {
        var transform = CGAffineTransform(translationX: dx, y: dy).scaledBy(x: scale, y: scale)
        if let cg = self.cgPath.copy(using: &transform) {
            return Path(cg)
        }
        return self
    }
}
