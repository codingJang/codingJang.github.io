---
layout: post
title: 머신러닝은 양자역학 시뮬레이션을 가속화할 수 있을까?
date: 2024-04-20 10:00:00
description: ML-accelerated QM simulations for industrial applications 논문 요약
tags: machine-learning quantum-mechanics simulation korean
categories: research
---

### Machine learning-accelerated quantum mechanics-based atomistic simulations for industrial applications

## Abstract

- ML methods has dramatically extended the applicability range of conventional QM-based simulations
- This paper will illustrate the benefits of ML methods in drug discovery and energy materials

# Introduction

- Computer-aided drug design
    - lower cost, decrease failure rates, speed up
- Focuses on ML-accelerated QM methods and compares them with two main conventional approaches (MM and QM)

# Atomistic Simulation Methods

- PES (Potential Energy Surface)
- MD (Molecular Dynamics) or MC (Monte Carlo)
- The degree of physical approximation gives how more or less efficient a simulation is
- Non-emperical QM methods are the most accurate yet computationally most expensive
- **The choice of simulation depends on the four key aspects:**
    - types of physical approximations made
    - computational efficiency of the method
    - transferability
    - usability

## MM-based simulations

- often derived from experimental input
- computationally efficient 👍
- can handle larger systems when combined with coarse-grain approaches 👍
- the results are not generalizable 😥
- cannot describe the breaking and forming of chemical bonds 😥

## QM-based simulations

- Solves the Schrodinger equation using DFT
- can be applied to all chemical species 👍
- can obtain a large set of material properties 👍
- high computational cost 😥
- cannot be used for larger systems 😥

## Overcoming the limitations of QM-based simulations using machine learning

- Takes the form of one of 4 methods:
    1. Extension of the applicability range to QM simulations to larger length and time scales
    2. Prediction of properties calculated from QM methods
    3. Automated analysis of simulation data
    4. Inversion of atomistic calculations to generate atomic structures for a given set of properties

Strategy 1

- construct MLP(machine-learning potentials)
- computational cost goes from $O(n^3)$  to $O(n)$

Strategy 2

- Trained to yield the outcome of QM-based calculations from atomistic simulations results
- less general than MLPs by construction

Strategy 3

- used for automatic ID of crystal structures etc.

Strategy 4

- currently in its infancy
- are not yet standardized and usability is therefore generally not yet given