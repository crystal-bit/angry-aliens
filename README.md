
# Angry Aliens

![optimized](https://user-images.githubusercontent.com/6860637/79353473-60ad7580-7f3b-11ea-8bc7-411bab23032e.gif)

**Angry Aliens** is an open source game made with Godot Engine 3.2.1.

Source code is MIT licensed. Feel free to read it, modify it and reuse it in your projects.

Gameplay is definitely inspired by *Angry Birds*.

### Disclaimer

> This project is used as a base for video tutorials in Italian. All the source code and documentation is in English.
> If you are interested, videos are released [on my Crystal Bit YouTube channel](https://www.youtube.com/playlist?list=PLaCq3HqKQR6rNyqulBsbca-6wzxp8H52r).

## Table of Contents

- [Angry Aliens](#angry-aliens)
    - [Disclaimer](#disclaimer)
  - [Table of Contents](#table-of-contents)
  - [Branches: `master`, `develop` and `video`](#branches-master-develop-and-video)
  - [Prerequisites](#prerequisites)
  - [Tutorial Contents](#tutorial-contents)
    - [1. Introduction](#1-introduction)
    - [2. Configure Godot and Android SDK](#2-configure-godot-and-android-sdk)
    - [3. Testing performances on the smartphone](#3-testing-performances-on-the-smartphone)
    - [4. Slingshot](#4-slingshot)
    - [5. Level (for multiple resolutions)](#5-level-for-multiple-resolutions)
    - [6. Enemies](#6-enemies)
    - [7. Obstacles](#7-obstacles)
    - [[EXTRA] Possible improvements / future topics](#extra-possible-improvements--future-topics)
  - [Credits](#credits)
  - [Thanks](#thanks)
  - [Support me](#support-me)

## Branches: `master`, `develop` and `video`
- `develop` branch contains the complete project.Some advanced features may not be included in the master branch.
- `master` branch will be in sync with video tutorials releases on my YouTube channel.
- `videoX/start` branches contains the code to follow the tutorial number `X`. Example:
  - `video5/start` contains the code to follow the [video tutorial 5](https://youtu.be/SVuOYKzTwxw) on YouTube.

## Prerequisites

The tutorials require basic Godot understanding about Scenes, GDScript, 2D Nodes such as Sprite2D, CollisionShape2D, Area2D.

You can learn these topics by:

- reading the [official documentation](https://docs.godotengine.org/en/3.1/getting_started/step_by_step/intro_to_the_editor_interface.html)
- following my [video tutorial series](https://www.youtube.com/watch?v=AY1zuH2mHQ0&list=PLaCq3HqKQR6rlPpf2GAOXp52ddt0V71Yl) on Godot 3 basics (*only in Italian*)

## Tutorial Contents

### 1. Introduction

- 🎥 [YouTube - #1 - Introduzione](https://youtu.be/x0emyyXC_sM)

This tutorial series will focus on creating a simple mobile game
using Godot 3.2.

I choose to make an Angry Birds clone because:

1. it is short to recreate (without adding polish) 
2. it allows to stress Godot performances on the worst case scenario: intense game (physics based) on a low-power device (smartphone)

I'm creating these tutorials using Manjaro Linux (Arch Linux derivative), but similar steps can be done on other operating systems as well.

Currently I don't have an Apple device and I cannot develop/test iOS/OSX games. I'll try to provide instructions for other OSs, but help here is really appreciated (especially if you are a Debian, Ubuntu, Windows or OSX user).

### 2. Configure Godot and Android SDK

- 🎥 [YouTube - #2 - Configurare Linux](https://youtu.be/xFia7zG8NGA)
- 🎥 [YouTube - #3 - Configurare Windows](https://youtu.be/PNj8YmXjj-A)
  
> How do I configure my computer for Android development?

- `android-tools` and `jdk-openjdk`
- debug keystore
- Godot configuration
- Export templates
- **APK creation**
- APK one click installation

### 3. Testing performances on the smartphone

- 🎥 [YouTube - #4 - Creare il livello](https://youtu.be/VZS0pv14--s)
- 🎥 [YouTube - #5 - Creare la scena StressTest (pt1)](https://youtu.be/SVuOYKzTwxw)
- 🎥 [YouTube - #6 - Stress test (pt.2) - Debugger e profiler](https://youtu.be/s4jSWPtqR8M)
- 🎥 [YouTube - #7 - Stress test (pt.3) - Debugging su Android con Remote Debugger](https://youtu.be/-z6w9ArPFBY)

> If we include all the physics elements and we create hundreds of game objects, is the game playable?

![Stress test scene screen](Assets/readme/stress-test.png)

### 4. Slingshot

- 🎥 [YouTube - #8 - Lancio Proiettili (Pt.1)](https://youtu.be/W16SLhgp8Zk)
- 🎥 [YouTube - #9 - TouchScreen Input: Press, Release e Drag - Lancio Proiettili (Pt.2)](https://youtu.be/vVDVJMomxBU)
- 🎥 [YouTube - #10 - input e unhandled_input](https://youtu.be/ZuBWgmOB_Gs)

> How to create a slingshot that reacts on touchscreen and mouse input

- Create a projectile
- Create a simple slingshot
- Input handling for mouse and touchscreen
- Projectile launch
- Load new projectile

### 5. Level (for multiple resolutions)

- 🎥 [#11 - Risoluzioni Multiple (pt1)](https://youtu.be/uuRF0yJ6P1M)
- 🎥 [#12 - Risoluzioni Multiple (pt2)](https://youtu.be/va4RFkUQ6xg)

![Image level screen](Assets/readme/level.png)

- Mobile Layout
- Multiple resolutions handling

### 6. Enemies


- 🎥 [#13 - Quantità di moto e gestione delle collisioni (pt1)](https://youtu.be/rAp0APW_aAQ)
- 🎥 [#14 - _integrate_forces: gestione collisioni (pt2)](https://youtu.be/cjRhymHrIe4)

- Rigid bodies with collision detection
- Enemies destruction
- enemy destroyed signal

### 7. Obstacles

- 🎥 [#15 - Aggiungere ostacoli e generalizzare le collisioni](https://youtu.be/yfljmFIFHOg)

- Obstacle scene
- Obstacle destruction
- `CollisionHandler` node to generalize collision physics

### [EXTRA] Possible improvements / future topics

Extra topics are available in the `develop` branch.

They are not tutorialized, but the code should be simple to understand.

More than that, there are still a lot of areas that can be explored like:

- Camera handling (pan, focus, zoom, ...)
- Publishing on a game store
  - Fdroid
  - Play Store
- Managing audio sfx
- Improve the slingshot elastic animation
- Parallax background
- Moving clouds
- Particle effects
- Android modules
- Double tap, drag 'n drop, pinch to zoom,...
- Using Sensors (GPS, accelerometer, light sensor, bluetooth,...)

## Credits

- **Kenney** for most of the game assets - https://www.kenney.nl/
- **Hanabi** for the slingshot sprites

## Thanks

- Crystal Bit community for the continuos support
- Gameloop.it community for the Harvard [CS50 gamedev course](https://github.com/GameLoop-it/cs50_course_materials)
- [YouAreUto](http://youareuto.com/) game & team
- [Godot Engine Italia](https://godotengineitalia.com/)
