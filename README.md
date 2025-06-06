# FlappySwift

> This project is the one that started my career in Swift and as a book author. — Gio Scalzo

FlappySwift is a modern, clean, and modular implementation of the classic Flappy Bird game, written entirely in Swift. It was the foundation for my journey into iOS development and technical writing.

## 📽️ Demo Video

https://github.com/user-attachments/assets/6428bde2-827b-4335-94f9-87ff71274703


---

## 🗂️ Module Diagram

```mermaid
graph TD
    MenuViewController -->|presents| GameViewController
    GameViewController -->|hosts| GameScene
    GameScene -->|uses| Bird
    GameScene -->|uses| Pipes
    GameScene -->|uses| Background
    GameScene -->|uses| Score
    GameScene -->|uses| AlertWrapper
    GameScene -->|uses| MusicPlayer
    GameScene -->|uses| utilities
    Pipes --> PipesNode
    Background --> ParallaxNode
    MenuViewController --> FSPressableButton
```

---

## 📝 About

- **Author:** Gio Scalzo
- **Original Year:** 2014
- **Renewed Year:** 2025
- **Language:** Swift
- **License:** MIT

This codebase is a great starting point for learning SpriteKit, game architecture, and modular Swift design. Enjoy hacking and flying! 
