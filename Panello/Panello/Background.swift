//
//  Background.swift
//  Panello
//
//  Created by Andrew Roberts on 4/18/17.
//  Copyright © 2017 Andrew Roberts. All rights reserved.
//
// TODO: -Add animated background shapes to background?
//       -Add functionality to select background

import GLKit

class Background {
    
    // -------------------------------------------------------------------
    // MARK: - Static members
    // -------------------------------------------------------------------
    private static var program: GLuint = 0
    private static let quad: [Float] = [ -1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0 ]
    
    /* Background designs */
    
    // Background 1 - Blue to red horizontal gradient
    private static let background1: [Float] = [ 0.7, 0.0, 0.0, 1.0,
                                                0.7, 0.0, 0.0, 1.0,
                                                0.0, 0.0, 0.7, 1.0,
                                                0.0, 0.0, 0.7, 1.0 ]
    
    // Background 2 - Blue to red "forward slash" diagonal gradient
    private static let background2: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                1.0, 0.0, 0.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0 ]
    
    // Background 3 - Blue to red vertical gradient
    private static let background3: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                1.0, 0.0, 0.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0 ]
    
    // Background 1 - Blue to red vertical gradient
    private static let background4: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                1.0, 0.0, 0.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0 ]
    
    // Background 1 - Blue to red "back slash" diagonal gradient
    private static let background5: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                1.0, 0.0, 0.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0 ]
    
    // Background 1 - Blue to red vertical gradient
    private static let background6: [Float] = [ 1.0, 0.0, 0.0, 1.0,
                                                1.0, 0.0, 0.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0,
                                                0.0, 0.0, 1.0, 1.0 ]

    private var _background: [Float]
    
    
    init() {
        _background = Background.background1
        Background.setup()
    }
    
    // -------------------------------------------------------------------
    // MARK: - Static functions
    // -------------------------------------------------------------------
    
    /* Set up the OpenGL program if necessary */
    private static func setup() {
        
        if (Background.program != 0) {
            return
        }
        
        // Vertex Shader
        let backgroundVertexShaderPath: String = Bundle.main.path(forResource: "BackgroundVertex", ofType: "glsl", inDirectory: nil)!
        let backgroundVertexShaderSource: NSString = try! NSString(contentsOfFile: backgroundVertexShaderPath, encoding: String.Encoding.utf8.rawValue)
        var backgroundVertexShaderData = backgroundVertexShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        let backgroundVertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        
        // why is nil allowed??
        glShaderSource(backgroundVertexShader, 1, &backgroundVertexShaderData, nil)
        glCompileShader(backgroundVertexShader)
        
        // check if compilation succeeded
        var backgroundVertexShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(backgroundVertexShader, GLenum(GL_COMPILE_STATUS), &backgroundVertexShaderCompileStatus)
        if (backgroundVertexShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(backgroundVertexShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(backgroundVertexShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Background vertex shader compilation successful.")
        }
        
        
        // Fragment Shader
        let backgroundFragmentShaderPath: String = Bundle.main.path(forResource: "BackgroundFragment", ofType: "glsl", inDirectory: nil)!
        let backgroundFragmentShaderSource: NSString = try! NSString(contentsOfFile: backgroundFragmentShaderPath, encoding: String.Encoding.utf8.rawValue)
        var backgroundFragmentShaderData = backgroundFragmentShaderSource.cString(using: String.Encoding.utf8.rawValue)
        
        let backgroundFragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
        
        // why is nil allowed??
        glShaderSource(backgroundFragmentShader, 1, &backgroundFragmentShaderData, nil)
        glCompileShader(backgroundFragmentShader)
        
        // check if compilation succeeded
        var backgroundFragmentShaderCompileStatus: GLint = GL_FALSE
        glGetShaderiv(backgroundFragmentShader, GLenum(GL_COMPILE_STATUS), &backgroundFragmentShaderCompileStatus)
        if (backgroundFragmentShaderCompileStatus == GL_FALSE) {
            // TODO: handle error
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetShaderiv(backgroundFragmentShader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetShaderInfoLog(backgroundFragmentShader, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Shader compilation failed.")
        }
        else {
            print("Background fragment shader compilation successful.")
        }
        
        
        // Compile Program
        Background.program = glCreateProgram()
        glAttachShader(Background.program, backgroundVertexShader)
        glAttachShader(Background.program, backgroundFragmentShader)
        glBindAttribLocation(Background.program, 0, "position")
        glBindAttribLocation(Background.program, 1, "color")
        glLinkProgram(Background.program)
        
        
        var backgroundProgramLinkStatus: GLint = GL_FALSE
        glGetProgramiv(Background.program, GLenum(GL_LINK_STATUS), &backgroundProgramLinkStatus)
        if (backgroundProgramLinkStatus == GL_FALSE) {
            var logLength: GLint = 0
            let logBuffer = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
            glGetProgramiv(Background.program, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            glGetProgramInfoLog(Background.program, logLength, nil, logBuffer)
            let logString: String = String(cString: logBuffer)
            print(logString)
            fatalError("Error. Linking failed.")
        }
    }
    
    /* Draw the background */
    func draw() {
        glUseProgram(Background.program)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, Background.quad)
        glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, _background)
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
    }
}
