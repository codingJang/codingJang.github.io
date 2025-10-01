---
layout: post
title: "Introduction to PettingZoo"
date: 2024-02-07 10:00:00
description: Multi-agent reinforcement learning library for Python
tags: reinforcement-learning deep-learning MARL tutorial english series
categories: education
lang: en
---


## Documentation link

[PettingZoo Documentation](https://pettingzoo.farama.org/)

## Brief Introduction to PettingZoo

PettingZoo is a Python library that facilitates General Multi-Agent Reinforcement Learning (MARL) simulations.

PettingZoo consists of two main APIs:

- **AEC API**: Helps implement environments with turns between agents, similar to board games.
    - Environments with turns are called Agent Environment Cycle (AEC) environments.
- **Parallel API**: All agents act simultaneously within a single time step.
    - These are called Parallel environments, referring to parallel/concurrent execution.

There exist AEC-to-Parallel and Parallel-to-AEC converters that allow transformation between the two APIs. However, when developing for the first time, it's recommended to focus on one API without worrying too much about conversion.