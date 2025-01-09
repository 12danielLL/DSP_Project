# Digital Signal Processing (DSP) Project

## Overview
This project was part of a DSP course and focuses on designing, implementing, and analyzing signal processing algorithms. It includes:
1. Implementation of FFT and IFFT algorithms.
2. Design and conversion of analog filters (Butterworth) to digital filters using bilinear transformation.
3. Signal filtering using digital filters.
4. Linear convolution implementation with the Overlap-Add (OVA) method.

## Table of Contents
1. [Overview](#overview)
2. [Technologies Used](#technologies-used)
3. [Project Structure](#project-structure)
4. [File Structure](#file-structure)
5. [Getting Started](#getting-started)
6. [Results and Analysis](#results-and-analysis)
7. [License](#license)
8. [Contributors](#contributors)

## Technologies Used
- MATLAB R2020a or later
- Signal Processing Toolbox (optional for advanced visualization)

## Project Structure
### Key Scripts:
- `DSP_part1.m`: Implements FFT and IFFT without recursion and compares results with MATLAB built-in functions.
- `DSP_part2.m`: Contains filter design, FFT analysis, and filtering results using linear convolution and OVA methods.
- Supporting files:
  - `sig_2.mat`: Input signal for filtering.
  - `filter_0.25_101.mat`: FIR filter coefficients.

### Key Features:
1. **FFT and IFFT Implementation**:
   - Custom implementation of FFT using the Cooley-Tukey algorithm.
   - Verification against MATLAB's built-in functions.
2. **Digital Filter Design**:
   - Analog Butterworth filter transformed into a digital filter using bilinear transformation.
   - Magnitude and frequency responses visualized.
3. **Signal Filtering**:
   - Applied FIR and IIR filters to input signals.
   - Explored noise suppression and signal enhancement techniques.
4. **Overlap-Add Convolution**:
   - Efficient implementation for large signals.
   - Comparison of execution times with direct convolution.

## File Structure
```
.
├── DSP PART 1.pdf # Results document for Part 1  
├── DSP PART 2.pdf # Results document for Part 2
├── DSP part1 instructions.docx # Instructions for Part 1 
├── DSP part2 instructions.docx # Instructions for Part 2 
├── DSP_part1.m # Script for FFT and IFFT implementation 
├── DSP_part2.m # Script for filter design and analysis 
├── filter_0.25_101.mat # FIR filter coefficients 
├── filter_1.mat # Filter 1 coefficients 
├── filter_2.mat # Filter 2 coefficients 
├── part 1 matlab files.zip # ZIP file containing MATLAB files for Part 1 
├── sig_2.mat # Input signal for filtering 
├── sig_x.mat # Signal for convolution operations 
├── LICENSE # License file 
├── README.md # Project documentation
```
## Getting Started
### Prerequisites:
- MATLAB R2020a or later.
- Signal Processing Toolbox (optional for advanced visualization).

## Running the Project

1. Clone the repository:
   ```bash
   git clone https://github.com/12danielLL/DSP_Project
2. Load the required .mat files into MATLAB
3. Run the scripts in the following order:
- `DSP_part1.m`: This script implements FFT and IFFT algorithms. It compares the custom implementation against MATLAB's built-in functions for verification.
- `DSP_part2.m`: This script contains the design and conversion of filters, as well as signal filtering using convolution and the OVA method.

```
```
  ## Results and Analysis

- **Custom FFT vs Built-in FFT**: The custom implementation closely matches MATLAB's built-in functions in both time and frequency domains.

- **Filter Responses**:
  - Analog and digital filters designed as per specifications.
  - Visualized magnitude response of Butterworth filters in both analog and digital domains.

- **OVA vs Direct Convolution**:
  - OVA significantly reduces computational time for large signals.
  - Comparison of execution times shows the efficiency of the OVA method over direct convolution for large inputs.
## License

This project is licensed under the [MIT License](LICENSE). See the `LICENSE` file for details.

## Contributors

- Yuval Peretz
- Daniel Brooker
- Or Shachar

-This project was completed as part of the Digital Signal Processing (DSP) course at Bar-Ilan university.
