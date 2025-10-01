---
layout: post
title: 공개키 암호화 구조
date: 2024-05-20 10:00:00
description: RSA 암호화 방식과 공개키 암호화의 원리 (작성 중)
tags: cryptography RSA security mathematics korean draft
categories: cryptography
published: false
---

## 공개키 암호화

공개키 암호화 구조는 어떻게 동작하는가? 공개키 암호화 구조는 https 보안 연결이 성립하게 하기 위한 기반 기술이다. 우선 가장 대표적인 RSA 암호화 방식에 대해 알아보자.

## RSA 암호화

RSA 암호화는 아래 식에서 공개키로 지수 $e$와 모듈러스 $n$을 사용하고, 개인키로 $d$를 사용한다. 이때 아래 식은 메시지 $m$의 범위 $0≤m<n$에서 모두 만족되어야 한다.

$$
(m^e)^d \equiv m \pmod{n}
$$

$n=pq$ ($p$, $q$는 충분히 큰 소수)이며, ed=1 pmod n)을 만족하는 d는 e를 알 때