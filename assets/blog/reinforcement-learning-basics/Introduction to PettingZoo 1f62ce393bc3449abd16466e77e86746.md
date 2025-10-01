# Introduction to PettingZoo

## Documentation link

[PettingZoo Documentation](https://pettingzoo.farama.org/)

## PettingZoo 간략 소개

PettingZoo는 General MARL(General Multi-agent Reinforcment Learning) 시뮬레이션을 돌릴 수 있도록 돕는 파이썬 라이브러리이다.

PettingZoo는 크게 두 가지 API로 구성되어 있다:

- **AEC API**: 보드게임처럼 에이전트 사이의 차례(turn)가 있는 환경을 구현하도록 돕는다.
    - 차례가 있는 환경을 Agent Environment Cycle (AEC) 환경이라 칭한다.
- **Parallel API**: 한 타임 스텝 내에서 모든 에이전트가 동시에 행동(action)한다.
    - 병렬/평행의 의미로 Parallel 환경이라 칭한다.

AEC API와 Parallel API 사이에서 변환이 가능하도록 하는 AEC to Parallel 변환과 Parallel to AEC 변환이 존재한다. 그러나 처음 개발할 때는 너무 걱정하지 말고 하나의 API에 집중해서 개발하는 것이 좋을 것이다.