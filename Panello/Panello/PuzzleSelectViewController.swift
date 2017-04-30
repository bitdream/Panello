//
//  PuzzleSelectViewController.swift
//  Panello
//
//  Created by Andrew Roberts on 4/23/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//

import GLKit

class PuzzleSelectViewController: GLKViewController {
    
    // --------------------------------------------------------------------
    // MARK: - Instance data
    // --------------------------------------------------------------------
    
    /* Graphics */
    // Menu options
    private var back: TextRenderer!
    private var topTitle: TextRenderer!
    private var puzzle1Block: SmallRenderer!
    private var puzzle2Block: SmallRenderer!
    private var puzzle3Block: SmallRenderer!
    private var puzzle4Block: SmallRenderer!
    private var puzzle5Block: SmallRenderer!
    private var puzzle6Block: SmallRenderer!
    private var puzzle7Block: SmallRenderer!
    private var puzzle8Block: SmallRenderer!
    private var puzzle9Block: SmallRenderer!
    private var puzzle10Block: SmallRenderer!
    private var puzzle11Block: SmallRenderer!
    private var puzzle12Block: SmallRenderer!

    private var puzzle1: TextRenderer!
    private var puzzle2: TextRenderer!
    private var puzzle3: TextRenderer!
    private var puzzle4: TextRenderer!
    private var puzzle5: TextRenderer!
    private var puzzle6: TextRenderer!
    private var puzzle7: TextRenderer!
    private var puzzle8: TextRenderer!
    private var puzzle9: TextRenderer!
    private var puzzle10: TextRenderer!
    private var puzzle11: TextRenderer!
    private var puzzle12: TextRenderer!
    
    // Background
    private var puzzleBackground: BackgroundRenderer!
    
    // --------------------------------------------------------------------
    // MARK: - GLKViewController overrides
    // --------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;
        self.preferredFramesPerSecond = 1
        
        let context = AppDelegate.context
        puzzleView.context = context
        EAGLContext.setCurrent(context)
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
        back = TextRenderer(startCoordinateX: -0.5, startCoordinateY: 0.85, scale: 0.22)
        topTitle = TextRenderer(startCoordinateX: -0.42, startCoordinateY: 0.7, scale: 0.3)
        
        puzzle1 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.5, scale: 0.33)
        puzzle2 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: 0.5, scale: 0.33)
        puzzle3 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.25, scale: 0.33)
        puzzle4 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: 0.25, scale: 0.33)
        puzzle5 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: 0.0, scale: 0.33)
        puzzle6 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: 0.0, scale: 0.33)
        puzzle7 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: -0.25, scale: 0.33)
        puzzle8 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: -0.25, scale: 0.33)
        puzzle9 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: -0.50, scale: 0.33)
        puzzle10 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: -0.50, scale: 0.33)
        puzzle11 = TextRenderer(startCoordinateX: -0.45, startCoordinateY: -0.75, scale: 0.33)
        puzzle12 = TextRenderer(startCoordinateX: 0.15, startCoordinateY: -0.75, scale: 0.33)
        
        puzzle1Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: 0.5)
        puzzle2Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: 0.5)
        puzzle3Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: 0.25)
        puzzle4Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: 0.25)
        puzzle5Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: 0.0)
        puzzle6Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: 0.0)
        puzzle7Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: -0.25)
        puzzle8Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: -0.25)
        puzzle9Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: -0.50)
        puzzle10Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: -0.50)
        puzzle11Block = SmallRenderer(startCoordinateX: -0.30, startCoordinateY: -0.75)
        puzzle12Block = SmallRenderer(startCoordinateX: 0.30, startCoordinateY: -0.75)
        
        puzzleBackground = BackgroundRenderer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var puzzleView: GLKView {
        return view as! GLKView
    }
    
    // --------------------------------------------------------------------
    // MARK: - PuzzleSelectViewController methods
    // --------------------------------------------------------------------
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.0, 1.0, 0.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        let height: GLsizei = GLsizei(puzzleView.bounds.height * puzzleView.contentScaleFactor)
        let offset: GLsizei = GLsizei((puzzleView.bounds.height - puzzleView.bounds.width) * -0.5 * puzzleView.contentScaleFactor)
        glViewport(offset, 0, height, height)
        
        puzzleBackground.renderMenuBackground(menuBackground: 6)
        back.renderLine(text: "Back")
        topTitle.renderLine(text: "Select Puzzle")
        
        puzzle1.renderLine(text: "1")
        puzzle2.renderLine(text: "2")
        puzzle3.renderLine(text: "3")
        puzzle4.renderLine(text: "4")
        puzzle5.renderLine(text: "5")
        puzzle6.renderLine(text: "6")
        puzzle7.renderLine(text: "7")
        puzzle8.renderLine(text: "8")
        puzzle9.renderLine(text: "9")
        puzzle10.renderLine(text: "10")
        puzzle11.renderLine(text: "11")
        puzzle12.renderLine(text: "12")
        
        puzzle1Block.renderUnclear()
        puzzle2Block.renderUnclear()
        puzzle3Block.renderUnclear()
        puzzle4Block.renderUnclear()
        puzzle5Block.renderUnclear()
        puzzle6Block.renderUnclear()
        puzzle7Block.renderUnclear()
        puzzle8Block.renderUnclear()
        puzzle9Block.renderUnclear()
        puzzle10Block.renderUnclear()
        puzzle11Block.renderUnclear()
        puzzle12Block.renderUnclear()
    }
    
    private static func pixel(_ pixel: Int) -> Float {
        return Float(2*pixel + 1)/Float(2048)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.location(in: puzzleView)
        let glPointX: Float = Float((touchPoint.x/puzzleView.bounds.width) * 2 - 1) * Float(puzzleView.bounds.width/puzzleView.bounds.height)
        let glPointY: Float = Float((touchPoint.y/puzzleView.bounds.height) * 2 - 1) * -1
        
        if (back.touchedInside(x: glPointX, y: glPointY)) {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        if (puzzle1Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 1 Selected")
        }
        if (puzzle2Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 2 Selected")
        }
        if (puzzle3Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 3 Selected")
        }
        if (puzzle4Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 4 Selected")
        }
        if (puzzle5Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 5 Selected")
        }
        if (puzzle6Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 6 Selected")
        }
        if (puzzle7Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 7 Selected")
        }
        if (puzzle8Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 8 Selected")
        }
        if (puzzle9Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 9 Selected")
        }
        if (puzzle10Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 10 Selected")
        }
        if (puzzle11Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 11 Selected")
        }
        if (puzzle12Block.touchedInsideSmall(x: glPointX, y: glPointY)) {
            print("Puzzle 12 Selected")
        }
        
        print("\(glPointX), \(glPointY)")
    }
}
