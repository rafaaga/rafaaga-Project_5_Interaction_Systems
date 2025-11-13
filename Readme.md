# FC Barcelona Champions League Sonification

## Project Members
- Rafael Hermida Toledo
- Sebastián Castro Obando

## Project Description

This project transforms **FC Barcelona’s 2024–2025 Champions League performance** into a procedural audiovisual experience.  
Using **Processing** and **Pure Data**, real match data is converted into dynamic sound and visuals.  
Each match produces a unique soundscape based on the team’s statistics, allowing listeners to *hear* the story of Barcelona’s journey through the tournament.

## About the Concept

Sports data is full of rhythm, tension, and emotion — just like music.  
This project sonifies match statistics to express victory, defeat, and intensity through sound.  
Each element of the match (result, goals, and phase) is mapped to specific musical parameters, turning raw numbers into an expressive performance.

## Tools Used

- **Processing**: For data visualization and real-time control via UDP  
- **Pure Data (PD)**: For procedural audio generation and synthesis  
- **CSV Dataset**: [Scores and Fixtures 2024–2025 Barcelona Champions League (Kaggle)](https://www.kaggle.com/datasets/aliratel01/fc-barcelona-champions-league-2425-stats?resource=download&select=Scores_and_Fixtures_2024-2025_Barcelona__Champions_League.csv)

## Sonification Approach

The sound is built from two main layers:

### 🎵 Tone Layer
- **Frequency (pitch)** depends on the **match result**  
  - Win → bright, high pitch (≈ 800 Hz)  
  - Draw → mid tone (≈ 500 Hz)  
  - Loss → low, heavy pitch (≈ 200 Hz)  
- **Amplitude (volume)** increases with **goals scored**  
- **Tremolo speed** increases with the **tournament phase**, adding emotional tension in later rounds  

### 🌫 Noise Layer
- **Noise intensity** depends on **goals conceded**  
  - More goals against → louder and rougher noise  
- Used to represent instability and defensive pressure during the match  

Both layers are combined into a single stereo output that evolves with each game.

## Visual Component (Processing)

- **Arrow direction** → Win (up), Draw (center), Loss (down)  
- **Background color** → Blue for home, red for away  
- **Flashing speed** → Increases as the tournament advances  
- **Score and opponent** displayed on screen  
- Clicking advances to the next match  

## Requirements Met

- ✅ **Use of Pure Data and Processing**: Both tools are integrated via UDP communication.  
- ✅ **Visual and sound representation**: The visuals and sound change dynamically according to each match.  
- ✅ **Use of a public dataset**: Data obtained from a public Kaggle dataset.  
- ✅ **Synchronization between audio and visuals**: Both the soundscape and animation respond to the same data points (result, goals, and phase).  

## Video Demonstration
*(To be added after final recording of the project.)*

## Course Context

This project was created for the **Interactive Systems** course, demonstrating data-driven audiovisual interaction using Processing and Pure Data.  
It explores the emotional translation of real sports data into sound and visuals.
