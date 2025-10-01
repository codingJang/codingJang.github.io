---
layout: post
title: 군의 정의와 예시
date: 2024-05-10 10:00:00
description: 추상대수학의 기초 - 군론 입문
tags: mathematics group-theory abstract-algebra korean
categories: mathematics
---

## 군의 정의

집합 $G$와 $G$의 원소들에 대해 정의된 닫혀 있는 이항연산자 $*: G\times G \rightarrow G$에 대해, 다음 조건을 만족하면 $\left<G,* \right>$는 군을 이룬다:

1. 항등원이 존재한다.
즉, 모든 $a \in G$에 대해 $a * e=e * a=a$를 만족하는 $e \in G$가 존재한다.
2. 모든 원소에 대한 역원이 존재한다.
즉, 모든 $a \in G$에 대해 $a * a^{-1}=a^{-1} * a=e$를 만족하는 $a^{-1} \in G$가 존재한다.
3. 결합 법칙이 성립한다.
즉, 모든 $a,b,c \in G$에 대해 $(a*b)*c=a*(b*c)$이다.

### **군의 예시**

집합 $G=\{0, 1, 2, 3, 4, 5\}$에 대해 이항연산자 $\oplus$를 아래와 같이 정의한다:

$$
a\oplus b=(a+b를\:6으로\:나눈\:나머지)
$$

그렇다면 $\left<G,\oplus \right>$는 군을 이룬다. 그 이유는:

1. $a \oplus b$는 $0$ 이상 $6$ 미만의 정수이므로 집합 $G$가 연산 $\oplus$에 대해 닫혀 있음은 자명하다.
2. 모든 $a \in G$에 대해 $a\oplus 0=0\oplus a=a$이기 때문에 항등원 $0$이 존재한다.
3. $0$의 역원은 $0$이고, $1$의 역원은 $5$, $2$의 역원은 $4$, $3$의 역원은 $3$, $4$의 역원은 $2$, $5$의 역원은 $1$이다. 따라서 모든 원소에 대해 역원이 존재한다.
4. $(a \oplus b) \oplus c = a \oplus (b \oplus c) = (a + b + c\textrm{를 6으로 나눈 나머지})$이므로 결합법칙이 성립한다.

추가적으로, 교환법칙이 성립하므로 $\left<G,\oplus \right>$는 가환군(commutative group)을 이룬다. 가환군은 아벨군(Abelian group)이라고도 부른다.