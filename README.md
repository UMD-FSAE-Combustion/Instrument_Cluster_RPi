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
  - Save up to 6 profiles for automated setting adjustments between drivers
  - Drivers can configure brake biasing with 1% increments
  - Drivers can configure traction control adjustment, launch aim ajustment, and anti-lag adjustment
  - Toggleable launch control
  - Toggleable adjustment switches for various settings, with state saving per profile.
* Advanced vehicle diagnostics
  - Easily readable interface for important vehicle information updated in real time
* Warning messages for ECU faults/issues, with specific fault information
* In-vehicle video games
* Easter eggs for drivers to discover

## How To Use
The Driver interface is designed to work with buttons wired to the Raspberry Pi, however, we have also included a set of keypresses that work to emulate the controls.

### Main Controls:
The controls below work on the Windows demo as well as when running on a Linux desktop enviornment.  
When deploying on hardware, the arrow key functionality is emulated by the GPIO fitted to the dashboard.
The extra key functionality is not supported when deploying on hardware.
* Arrow Keys
  -  Left: Open game menu or select the hilighted item in game menu 
  - Right: Open options menu or select the highlighted item in options menu 
  -    Up: Scroll upward
  -  Down: Scroll downward
* Extra Keys
  - W: Simulate ECU fault warning
  - P: Power off (only on PiOS, will not work on other operating systems
  - Escape or Q: Close application

## Download
The program was originally designed to be used on a Raspberry Pi, however, a demo mode with limited functionality is available to run on Windows for showcasing purposes.  MacOS devices are currently not supported.

### [WINDOWS DEMO MODE](https://drive.google.com/uc?export=download&id=1rG-5VdMCZWO9uEFCSWf7wuHeWG2dGbOI)
Click on the header above to download the .zip file containing the Windows demo application.  Simply unzip the file and launch the .exe file to run the demo.
The demo will support most UI functions, including animations, easter eggs, and games, but most backend functionality is removed from the demo.
Controls can be found <a href="#how-to-use">here</a>, or in the readme file included in the zip file.

---

### LINUX
To run on a Debian-based desktop environment, the following is required: <br>
First, download and install WiringPi
```
git clone https://github.com/WiringPi/WiringPi
cd WiringPi
./build
```
Next, install required Qt dependencies
```
sudo apt install libxcb-cursor0 libxcb-cursor-dev
```
Finally, download the application and run it
```bash
# For x86:
git clone https://github.com/UMD-FSAE-Combustion/Wolverine-Racing-Dash.git
cd linux-dash-code-Wolverine-Racing
./app_Dash

# For ARM:
git clone https://github.com/UMD-FSAE-Combustion/Wolverine-Racing-Dash-ARM.git
cd linux-dash-code-Wolverine-Racing-ARM
./app_Dash
```

To take full advantage of the system, a CAN device of some sort is required and socketCAN drivers must be loaded.
CAN interface creation varies by hardware device, so refer to the device instructions to enable a socketCAN interface.
If can messages need to be viewed for any reason, it's recommended to use `can-utils`:
```
sudo apt install can-utils
candump -tz can0
```
## Credits

This software uses the following open source packages:

- [Qt (Community Edition)](http://qt.io/)
- [WiringPi](https://github.com/WiringPi/WiringPi)

## License

MIT
##

<h1 align="center">
  <br>
  <a href="WolverineRacing"><img src="https://github.com/Mgharbieh/Instrument_Cluster_RPi/blob/main/assets/images/teamlogo.png" alt="WolverineRacing" width="650"></a>
  <br>
</h1>

