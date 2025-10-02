---
layout: post
title: "DeepMind X UCL | 4. Theoretical Fundamentals of Dynamic Programming"
date: 2024-02-02 10:00:00
description: Reinforcement Learning Basics Series
tags: reinforcement-learning deep-learning tutorial english series
categories: education
lang: en
---


## The Banach Fixed Point Theorem

Let $X$ be a complete normed vector space, equipped with a norm $\|\cdot\|$ and $T:X \rightarrow X$ a $\gamma$-contraction mapping, then:

1. $T$ has a unique fixed point $x^* \in X$ s.t. $T x^*=x^*$
2. $\forall x_0 \in X$, the sequence $x_{n+1}=Tx_n$ converges to $x^*$ in a geometric fashion:
    
    $$
    \|x_n-x^*\| \le \gamma^n\|x_0-x^*\|
    $$
    
    Thus, $\lim_{n\rightarrow\infty}\|x_n-x^*\|\le \lim_{n\rightarrow\infty}\gamma^n\|x_0-x^*\|=0.$
    

## What does this mean?

It means that if the distance between two points after applying some operator $T$ is no greater than the original distance multiplied by $\gamma \in [0, 1)$, then applying the operator repeatedly to any point $x_0$ to yield $x_n$ is a great way to search for the unique fixed point of the operator $T$.

## Definitions of the Bellman Operators

### Definition: Bellman Optimality Operator $T_V^*$

Given an MDP, $M=\langle S, A, p, r, \gamma \rangle$, let $V=V_S$ be the space of bounded real-valued functions over $S$. We define, point-wise, the Bellman Optimality Operator $T_V^*:V\rightarrow V$ as:

$$
(T_V^*f)(s)=\max_{a \in A} \biggl[ {r(s, a) + \gamma \mathbb{E} \left[f(s')|s, a\right]} \bigg], \;\forall f \in V
$$

Sometimes we drop the index and use $T^*=T_V^*$.

### What is this operator?

This operator is a $\gamma$-contraction with the unique fixed point being $f=v^*$, the optimal value function of the MDP. Therefore, if we apply this operator iteratively to some (value) function $v$, it will converge to the optimal value function $v^*$. This is why we attempt to approximate this specific operator (possibly with a neural network).

### Definition: Bellman Expectation Operator $T^\pi_V$

Given an MDP, $M=\langle S, A, p, r, \gamma \rangle$, let $V=V_S$ be the space of bounded real-valued functions over $S$. For any policy $\pi:S \times A \rightarrow [0, 1]$, we define, point-wise, the Bellman Expectation Operator $T_V^\pi:V\rightarrow V$ as:

$$
(T_V^\pi f)(s)=\mathbb{E}^\pi \bigg[ r(s, a) + \gamma  f(s') \bigg| s \bigg], \;\forall f \in V
$$

Note: By the tower rule, this is equivalent to:

$$
(T_V^\pi f)(s)=\mathbb{E}^\pi \biggl[ {r(s, a) + \gamma \mathbb{E} \left[f(s')|s, a\right]} \bigg| s \bigg], \;\forall f \in V
$$

Which is the same as the Bellman Optimality Operator, except $\max_{a\in A}$ being replaced by $\mathbb{E}^\pi[\cdot|s]$.

Sometimes we drop the index and use $T^\pi=T_V^\pi$.

### What is this operator?

Same as the Bellman Optimality Operator, this operator is a $\gamma$-contraction except the unique fixed point being $f=v^\pi$, the value function for policy $\pi$ in a given MDP. Therefore, we can evaluate the policy $\pi$ by repeatedly applying this operator to the initial (value) function $v$. We then know whether the policy $\pi$ is doing well or not.

### Definition: Bellman Optimality Operator $T_Q^*$

Given an MDP, $M=\langle S, A, p, r, \gamma \rangle$, let $Q=Q_{S, A}$ be the space of bounded real-valued functions over $S\times A$. We define the Bellman Optimality Operator $T_Q^*:Q\rightarrow Q$ as:

$$
(T_Q^* f)(s, a)=\mathbb{E} \bigg[ r(s, a) + \gamma  \max_{a'\in A}f(s',a') \bigg| s, a \bigg], \;\forall f \in Q
$$

Note: You can push the expectation inside to get

$$
(T_Q^* f)(s,a)={r(s, a) + \gamma \mathbb{E} \left[\max_{a'\in A} f(s',a')\bigg|s, a\right]}, \;\forall f \in Q
$$

### What is this operator?

This is the q-version of the previous Bellman Optimality Operator $T_V^*$. Similarly, this operator is a $\gamma$-contraction with the unique fixed point being $f=q^*$, the optimal q-value function of the MDP. Therefore, if we apply this operator iteratively to some (value) function $q$, it will converge to the optimal value function $q^*$. We may attempt to approximate this operator too.

### Definition: Bellman Expectation Operator $T^\pi_Q$

Given an MDP, $M=\langle S, A, p, r, \gamma \rangle$, let $Q=Q_{S, A}$ be the space of bounded real-valued functions over $S\times A$. For any policy $\pi:S \times A \rightarrow [0, 1]$, we define, point-wise, the Bellman Expectation Operator $T_Q^\pi:Q \rightarrow Q$ as:

$$
(T_Q^\pi f)(s, a)=\mathbb{E}^\pi \bigg[ r(s, a) + \gamma  f(s',a') \bigg| s, a \bigg], \;\forall f \in Q
$$

Note: You can push the expectation inside to get

$$
(T_Q^\pi f)(s, a) = r(s, a) + \gamma \mathbb{E^\pi} \bigg[ f(s',a')\bigg|s, a\bigg], \;\forall f \in Q
$$

### What is this operator?

This is the q-version of the previous Bellman Expectation Operator $T_V^\pi$. It is also a $\gamma$-contraction, with the unique fixed point being $f=q^\pi$. Therefore, we can evaluate the policy $\pi$ by repeatedly applying this operator to the initial value function $q$. We then know the performance of the policy $\pi$. Since this is a q-value function, we can also use it to greedify our policy $\pi$ by $\pi \leftarrow \operatorname{argmax}_{a\in A} q^\pi(s, a)$.

## Properties of the Bellman Operators

### Properties: Bellman Optimality Operator $T_V^* \;(= T^*)$

1. $T^*$ has a unique fixed point $v^*$.
2. $T^*$ is a $\gamma$-contraction with respect to $\|\cdot\|_\infty$:
    
    $$
    \|T^*v-T^*u\|_\infty \le \gamma \|v-u\|_\infty, \forall u,v \in V
    $$
    
3. $T^*$ is monotonic:

$$
\forall u,v \in V \text{ s.t. } u \le v \text{ component-wise, then } T^*u \le T^*v
$$

**The properties are similar for all other operators.**

## Approximate DP

So far, we have assumed perfect knowledge of the MDP & perfect/exact representation of the value functions. However, we often encounter situations where we don’t know the underlying MDP or cannot represent the value function exactly after each update.

Therefore, we will have to use approximate versions of the value functions / Bellman Operators. However, when the approximation is really bad, iteratively applying the approximated Bellman Operator to an initial function may not guarantee convergence.

An example of divergence induced by some approximation is explored in the lecture. However, in most cases, divergence is not an issue. In the lecture, it is mentioned that “sample versions of these algorithms converge under mild conditions, and even for the function approximation case, the theoretical danger of divergence is rarely materialised in practice.”

## Theorem (Value of a greedy Policy)

Consider an MDP. Let $q:S\times A \rightarrow \mathbb{R}$ be an arbitrary function and let $\pi$ be the greedy policy associated with $q$, then:

$$
\|q^* - q^\pi \|_\infty \le \frac{2\gamma}{1-\gamma} \|q^*-q\|_{\infty}
$$

where $q^*$ is the optimal value function associated with this MDP.

We can gain insights from this theorem:

1. Small values of $\gamma$ give a better (lower) upper bound for the potential loss of the performance. (Why?)
2. If $\gamma=0$, then $q^*=q^\pi$. Therefore, the greedy policy associated with any $q$ yields the optimal value function.
3. If $q=q^*$, it means that the value function, from which you are about to make the greedy policy out of, is the optimal value function. The greedy policy is the optimal policy, hence $q^*=q^\pi$ in this case.