# Analog Computing Workshop

### Algorithmic Art Unplugged: Creative Computing Exercises with Procedural Games for Pencils-and-Paper, Body Movement, and Spoken Words

In this two-hour workshop, we will explore creative coding "unplugged" — experimenting with principles of algorithmic art and computational thinking off the computer, IRL. Exercises in collaborative drawing, human flocking, and rule-based wordplay make for a great icebreaker. 

#### Materials

* Large timer, such as [https://vclock.com/timer/#countdown=00:01:00](https://vclock.com/timer/#countdown=00:01:00)
* Large adhesive post-it notes (4x6" or 6x8"), in 3 different colors
* Sharpie markers
* Large paper pads (18x24")
* Whiteboards and whiteboard markers
* Flashlight or bicycle light
* Tables which can sit 4-6 people



---

## Part 1. Algorithmic Body Movement Games


This section presents exercises in "human flocking", inspired by the dance/engineering performance *Flock Logic* (2010) by Naomi Leonard and Susan Marshall. It is also inspired by the landmark "Steering Behaviors" research by Craig Reynolds, and p5.js versions of that work in Dan Shiffman's [*Nature of Code*](https://thecodingtrain.com/tracks/the-nature-of-code-2/noc/5-autonomous-agents/1-steering-agents) project. 

![Flock Logic](images/flock-logic.jpg)

**Demonstration:**

* [*Coding Train p5.js Flocking Simulation*, with Sliders](https://editor.p5js.org/codingtrain/sketches/ry4XZ8OkN)

**Setup:** 

* Each person wears a large colored post-it on their shirt. Each post-it has a unique number written on it. For each game, the timer is set for two minutes. 

**Rules:**

1. *Alignment:* Avoid moving backwards. (It's not safe!)
2. *Repulsion:* Move away from anyone who is closer than arm’s length.
3. *Cohesion:* Always seek to keep ***N*** neighbors at arm's length. (N=2 works well.)

**(Japanese)**

1. 位置合わせ: 後方に移動しないようにします。 （安全ではありません！）
2. 反発: 腕の長さよりも近くにいる人から離れます。
3. 凝集：常に「N」人の隣人を腕の長さで保ちます。 (N=2 はうまくいきます。)

**Variations:**

* Change the value of N; try N=1, N=3.
* With N=1, try to always keep a neighbor on your *right side*, but not one person for too long.
* Maintain Rules 1,2, and 3. One or two special participants are given a flashing light. The group is instructed that those participants are now "predators". Participants should *evade* (keep a safe distance, like 2-3 meters from) the predators. The predators should experiment with applying pressure on the group, trapping and shaping the flock.
* Maintain Rules 1 and 2. Each participant should *avoid* the person whose number is one lower, and *seek* the person whose number is one higher. (Wrap the numbers around cyclically.)
* Maintain Rules 1 and 2. Suppose each participant has a number **X** on their post-it. Each participant should try to position themselves *halfway between* person **Y** and person **Z** (where Y=X+5 and Z=X+10).
* Maintain Rules 1 and 2. Each participant should look at the colors of post-its on other participants' shirts. Now: Red *avoids* Green, *seeks* Yellow; Green *avoids* Yellow, *seeks* Red; Yellow *avoids* Red, *seeks* Green.
* Maintain Rules 1, 2, and 3. Unbeknownst to the others, the organizer should give a small secret instruction paper to two special participants. The secret instruction should tell the special participants to to head for one corner of the room, or out a door, or to head to opposite corners of the room.

**Soundtracks for the Games:**

* Penguin Cafe Orchestra (1974): [*More Milk*](https://www.youtube.com/watch?v=ucYJMT65iSQ); [*Prelude and Yodel*](https://www.youtube.com/watch?v=vX_VktuqQOU), from 2:18+; [White Mischief](https://www.youtube.com/watch?v=rWVuJOjej9Q); [Isle of View](https://www.youtube.com/watch?v=RDqDFZHBbVA).


**References:** 

* "'*Flock Logic*' unites science and dance" [https://www.youtube.com/watch?v=3n7atKkg2Cg](https://www.youtube.com/watch?v=3n7atKkg2Cg) *(Watch from 1'00")*
* Naomi Leonard, Susan Marshall et al. "In the Dance Studio: An Art and Engineering Exploration of Human Flocking". [https://arxiv.org/pdf/1808.07842.pdf](https://arxiv.org/pdf/1808.07842.pdf)
* Leonard, N. E., Marshall, S.: *Flock Logic*. (2010) [Online]. Available:
[https://naomi.princeton.edu/flock-logic/](https://naomi.princeton.edu/flock-logic/)
* Dan Shiffman, [*Nature of Code: Steering Agents*]([*Nature of Code*](https://thecodingtrain.com/tracks/the-nature-of-code-2/noc/5-autonomous-agents/1-steering-agents))



---

## Part 2. 


--- 

## Part 3. Rule-Based Wordplay

We conclude our workshop with a game of *Zoom Schwartz Profigliano*. 

Vocabulary: 

* *ZOOM* means "Let's talk", or "Hello, I would like to begin a conversation with you". 
	* The speaker cannot ZOOM someone they are already in conversation with. 
* *SCHWARTZ* means "OK", or "I acknowledge that we are in conversation, and I reply to you". 
	* The speaker must already be in conversation with someone they SCHWARTZ.
* *Profigliano.* "Profigliano" means, "Look!" or "Hey, take a look at that person over there."
	* The speaker must *look at* a player who is not the one they're speaking to.





