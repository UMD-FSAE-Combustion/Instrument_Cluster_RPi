<h1 align="center">
  <br>
  <a href="WolverineRacing"><img src="https://github.com/Mgharbieh/Instrument_Cluster_RPi/blob/main/assets/images/teamlogo.png" alt="WolverineRacing" width="650"></a>
  <br>
</h1>

<h4 align="center">Driver-vehicle interface prioritizing configurability and ease of use.</h4>

<p align="center">
  <a href="#key-features">Key Features</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#download">Download</a> •
  <a href="#credits">Credits</a> 
</p>

## Key Features

* Load Driver Profiles - Quick, easy way to minimize downtime
  - Allow drivers to load their preferred configurations for dynamicx handling, letting them tune parameters to their tastes.
* Easy Configuration Customizations
  - Drivers can configure brake biasing, traction control, or launch control paramaters
* Advanced vehicle diagnostics
  - Easily readable interface for important vehicle information updated in real time
* Warning messages for ECU faults/issues
* In-vehicle video games
* Easter eggs for drivers to discover

## How To Use
The Driver interface is designed to work with buttons wired to the Raspberry Pi, however, we have also included a set of keypresses that work to emulate the controls.

### Main Controls:
The controls below work on the Windows demo as well as when running on a Linux desktop enviornment.  
When deploying on hardware, the arrow key functionality is emulated by the GPIO fitted to the dashboard.
The extra key functionality is not supported when deploying on hardware.
* Arrow Keys
  - Left: open options menu or select the highlighted item in options menu
  - Up:   Scroll upward
  - Down: Scroll downward
  - Right: Open game menu or select the hilighted item in game menu
* Extra Keys
  - W: Simulate ECU fault warning
  - P: Power off (only on PiOS, will not work on other operating systems
  - Escape or Q: Close application

## Download
The program was originally designed to be used on a Raspberry Pi, however, a demo mode with limited functionality is available to run on Windows for showcasing purposes.  MacOS devices are currently not supported.

### [WINDOWS DEMO MODE](https://drive.google.com/uc?export=download&id=1KGAqaMMBcgKybBMU_xWF1KtjLZEl3zSI)
Click on the header above to download the .zip file containing the Windows demo application.  Simply unzip the file and launch the .exe file to run the demo.
The demo will support most UI functions, including animations, easter eggs, and games, but most backend functionality is removed from the demo.
Controls can be found in the readme file included in the zip file.


### LINUX
***TODO: LINUX INSTALL INSTRUCTIONS*** 

## Credits

This software uses the following open source packages:

- [Qt (Community Edition)](http://qt.io/)
- [WiringPi](https://github.com/WiringPi/WiringPi)

## License

MIT

---
<h1 align="center">
  <br>
  <a href="WolverineRacing"><img src="https://github.com/Mgharbieh/Instrument_Cluster_RPi/blob/main/assets/images/teamlogo.png" alt="WolverineRacing" width="650"></a>
  <br>
</h1>

