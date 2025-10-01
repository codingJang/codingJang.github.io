---
layout: post
title: "Optical Quantum Gates"
date: 2024-03-21 10:00:00
description: 양자컴퓨팅 - 큐비트 이해하기
tags: quantum-computing qubits physics korean
categories: quantum
published: false
---


우선 아래 영상을 시청해보자.

[https://www.youtube.com/watch?v=zcqZHYo7ONs](https://www.youtube.com/watch?v=zcqZHYo7ONs)

- Main Point
    - Local-realism은 불가능하다.
    - Localism : 물체들은 빛의 속도 이하의 유한한 속도로 영향을 주고 받는다.
    - Realism : 실험 전에 각각의 광자가 편광 필터를 통과할지 알 수 있게 해주는 숨은 변수가 있다면,
    이는 수학적으로 모순을 가져온다.
- 의문
    - 설명 부족
        - 어떻게 하면 광자들을 이용해서 양자 얽힘을 실제로 구현할 수 있을까?
        - 찾아보기 : 광자의 양자 얽힘
    - 찾아보던 도중
        - **방해석(Calcite)**에 대해서 알게 되었음
            
            [https://www.youtube.com/watch?v=MoZar-gCj3E](https://www.youtube.com/watch?v=MoZar-gCj3E)
            
        - **방해석의 성질**
            - 편광 방향에 따라 빛의 진행 속력(즉, 파장)이 다름
        - **광자를 Qubit, 방해석을 Gate로 생각하면 어떠한가?**
            - 우선 방해석은 고유의 성질 때문에 :
                - 복굴절 (Double Refraction)
                    - 편광 방향에 따라 굴절률이 달라짐 → 수평/수직 편광 빛으로 분해할 수 있음
                    - measurement gate로 사용
                    
                    ![](/assets/img/blog/qubit/untitled.png)
                    
                - 파장판 (Waveplate)
                    - 수평/수직 편광 빛의 상대적 위상을 결정할 수 있음
                    - 회전 / 대칭 변환 gate로 사용
                    
                    ![출처 : Waveplate - Wikipedia](/assets/img/blog/qubit/untitled_1.png)
                    
                    출처 : Waveplate - Wikipedia
                    
                - **광자를 하나씩 보내는 상황을 생각해보자.**
                    - 각각의 광자는 Qubit에 대응되고, 밝기는 곧 확률 분포를 의미하게 된다.
                    
                    실제 논문에서 제시되어 있는 optical quantum gate
                    
                    Jeremy L. O'Brien. (2007). Optical Quantum Computing. Science (American Association for the Advancement of Science), 318(5856), 1567-1570.
                    
                    ![](/assets/img/blog/qubit/untitled_2.png)
                    
        - 그럼 양자 얽힘은 어떻게?
            - 논문에서는 (왜인지는 모르겠지만) 양자 얽힘 게이트를 만들기 힘들다고 나와 있음
            - 그러나 양자 얽힘을 만들 수 있는 방법은 나와 있음
                - 방해석과 같은 nonlinear crystal에 빛을 (아주 잘) 쪼여서 만들 수 있다고 함
                
                ![](/assets/img/blog/qubit/untitled_3.png)
                
            - CNOT 게이트도 가능...?