# A Workshop in Unplugged Computing

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
* Federico Albanese, [By the Deep Sea](https://www.youtube.com/watch?v=E0tiGN4pVXs)

**References:** 

* "'*Flock Logic*' unites science and dance" [https://www.youtube.com/watch?v=3n7atKkg2Cg](https://www.youtube.com/watch?v=3n7atKkg2Cg) *(Watch from 1'00")*
* Naomi Leonard, Susan Marshall et al. "In the Dance Studio: An Art and Engineering Exploration of Human Flocking". [https://arxiv.org/pdf/1808.07842.pdf](https://arxiv.org/pdf/1808.07842.pdf)
* Leonard, N. E., Marshall, S.: *Flock Logic*. (2010) [Online]. Available:
[https://naomi.princeton.edu/flock-logic/](https://naomi.princeton.edu/flock-logic/)
* Dan Shiffman, [*Nature of Code: Steering Agents*]([*Nature of Code*](https://thecodingtrain.com/tracks/the-nature-of-code-2/noc/5-autonomous-agents/1-steering-agents))
* Dan Shiffman, [*Coding Train p5.js Flocking Simulation*, with Sliders](https://editor.p5js.org/codingtrain/sketches/ry4XZ8OkN)



---

## Part 2. 


--- 

## Part 3. Rule-Based Wordplay

![Zoom game](images/zoom_schwartz.jpg)

(*30 minutes*) We conclude our workshop with a game of *Zoom Schwartz Profigliano* (ZSP). 

ZSP is a rule-based word game, ideally played by five people sitting in a circle. At any given time, two of the five players are in the "active conversation". Everyone at the table must keep track of which two players are currently having the active conversation. This is alot like tracing the state of a computer program! Various special words and actions change the set of people who are in the "active conversation". Sometimes ZSP is played as a drinking game (i.e., you take a drink when you make an error). 

ZSP はルールベースの単語ゲームで、理想的には 5 人が円になって座ってプレイします。 いつでも、5 人のプレイヤーのうち 2 人が「アクティブな会話」を行っています。 テーブルにいる全員が、現在アクティブな会話をしている 2 人のプレーヤーを追跡する必要があります。 これは、コンピューター プログラムの状態をトレースするのとよく似ています。 さまざまな特別な言葉や行動が、「アクティブな会話」に参加している人々のセットを変更します。 ZSP は飲酒ゲームとしてプレイされることもあります (つまり、エラーを犯したときに飲み物を飲む)。

### Vocabulary:

* **ZOOM** means "Let's talk!", or "Hello, I would like to begin a conversation with you". ZOOM *starts* a conversation with a new person. You can say ZOOM at any time, *except* that you cannot ZOOM someone you are *already* in conversation with.
* **SCHWARTZ** means "OK!", or "I acknowledge that we are in conversation, and I am replying to you". You must *already* be in conversation with someone you SCHWARTZ.
* **PROFIGLIANO** means "Look at them!" or "Hey, let's talk about that person." The PROFIGLIANO speaker must *look at* a third player who is *not* the one they're actively speaking to. PROFIGLIANO does not change the set of people who are in the current conversation.

Japanese:

* **ZOOM**とは「お話ししましょう！」、「こんにちは、お話を始めたいと思います」という意味です。 ZOOMは新しい人との会話を開始します。 いつでも ZOOM と言うことができますが、既に会話をしている相手を ZOOM することはできません。
* **SCHWARTZ** は「OK!」または「私たちが会話中であることを認め、あなたに返信します」という意味です。 あなたはすでに誰かと会話をしているに違いありません。
* **PROFIGLIANO** は「見てください！」という意味です。 または「ねえ、その人について話しましょう。」 PROFIGLIANO のスピーカーは、積極的に話している相手ではない 第三者に 目を向ける必要があります。PROFIGLIANO は、現在の会話に参加している人々のセットを変更しません。

### Fouls (Errors):

* If you speak or reply when you are not a part of the active conversation
* If you ZOOM someone you are *already* in conversation with
* If you SCHWARTZ someone you are *not* already in conversation with
* If you PROFIGLIANO, but you look at someone you are *already* in conversation with 

### Advanced Vocabulary:

* **BOINK**: Exactly like SCHWARTZ, but you must look down at your lap and blink.
* **BELVIDERE**: This is a ZOOM to the person on your left. You must raise your hands and exclaim BELVIDERE to the sky.
* **MEEP-MEEP** means "Goodbye". This allows you to leave the active conversation. The person you were speaking with is obliged to ZOOM (or BELVIDERE) someone else. 
* **QUAFFLE** means "What just happened?" It requires the quaffled player to repeat the word used immediately before the QUAFFLE. QUAFFLE has an "implied ZOOM function"; that is, the quaffled player (if not already in the active conversation) has also been effectively ZOOMed.

Japanese:

* **BOINK**: SCHWARTZ とまったく同じですが、膝を見てまばたきをする必要があります。
* **BELVIDERE**: これはあなたの左側の人への ZOOM です。 両手を上げてベルヴィデレを空に向けて叫ばなければなりません。
* **MEEP-MEEP**は「さようなら」という意味です。 これにより、アクティブな会話から離れることができます。 あなたが話していた人は、別の誰かをZOOM（またはBELVIDERE）する義務があります。
* **QUAFFLE** は「今何が起こったの？」という意味です。 クワッフルされたプレーヤーは、クワッフルの直前に使用された単語を繰り返す必要があります。 QUAFFLE には「暗黙の ZOOM 機能」があります。 つまり、クワッフルされたプレイヤー (まだアクティブな会話に参加していない場合) も効果的にズームされています。

### References:

* The complete rules are [in this PDF](resources/ZSP-Rules-2012.pdf).


