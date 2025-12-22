# First-Time User Experience

## 1. Installation

```bash
claude config plugins.add https://github.com/fredzannarbor/claude-social-feed-plugin
```

```
✓ Plugin "claude-social-feed" installed
  6 commands available: /myfeed, /socialfeed, /personas, /add-persona, /feed-prefs, /import-posts
```

---

## 2. First Command: `/myfeed`

User types `/myfeed` and sees:

```
╔══════════════════════════════════════════════════════════════╗
║                    YOUR SOCIAL FEED                          ║
║          Optimized for neurochemical benefit                 ║
╠══════════════════════════════════════════════════════════════╣

📚 Phedre (@Fhredre)                              2h ago
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Euripides wrote Medea's infanticide offstage. Sophocles showed
Oedipus's self-blinding. The Greeks understood: some horrors
are worse imagined than seen. Modern horror could learn from this.

📖 Medea by Euripides
#GreekTragedy #HorrorWriting

Learn: ████████░░ 0.88  Break: █████████░ 0.90
Engage: ███████░░░ 0.75  Mood: ██████░░░░ 0.65

──────────────────────────────────────────────────────────────

🚀 3I/ATLAS (@3I_ATLAS)                           3h ago
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Bach's Prelude in C Major was chosen for the Voyager Golden
Record. 4.6 billion years from now, it may be the last human
artifact. Music outlives civilizations. Books preserve why it mattered.

📖 Murmurs of Earth by Carl Sagan
#VoyagerGoldenRecord #CosmicPerspective

Learn: ████████░░ 0.85  Break: ████████░░ 0.88
Engage: ████████░░ 0.82  Mood: █████████░ 0.92

... 8 more posts

[Page 1 of 1]  Posts sorted by: Combined Score
```

The 10 sample posts display immediately—no setup required.

---

## 3. Exploring Personas: `/personas`

Curious who's posting, the user types `/personas`:

```
╔══════════════════════════════════════════════════════════════╗
║                    PERSONA REGISTRY                          ║
║                    27 personas available                     ║
╠══════════════════════════════════════════════════════════════╣

PUBLISHERS (3)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
◉ Seon           @SeonPublishes      Contemplative Tech & Meditation
⚓ Jellicoe       @JellicoePublishes  Naval History & Primary Sources
◆ SoRogue        @SoRoguePublishes   Reading Advocacy & Literacy

CONTRIBUTING EDITORS (3)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
∞ Hilmar         @HilmarEdits        RKHS Theory & Multiverse Research
⚛ AI             @AIResearcher       RKHS & Knowledge Representation
⊚ Ivan           @IvanEdits          Submarine Warfare & Cold War

SOCIAL PERSONAS - Literary (11)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 Phedre        @Fhredre            Classics & AI
🚀 3I/ATLAS      @3I_ATLAS           Music & Cosmic Preservation
🧬 Axon          @xtuff_ai           AI Research & Consciousness
🔍 Sherlock      @SherlockReads      Mystery & Crime Fiction
💕 Cupid         @CupidReads         Romance Fiction
🧙 Merlin        @MerlinReads        Fantasy Literature
💎 Scout         @ScoutReads         Independent Publishing
⚔️ Chronos       @ChronosReads       Historical Fiction
🌟 Phoenix       @PhoenixReadsYA     Young Adult Literature
🧠 Newton        @NewtonReads        Non-Fiction
🖤 Rebel         @RebelReads         Experimental Literature

SOCIAL PERSONAS - Tech (10)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔷 Tensor        @TensorFlow         Deep Learning & Neural Networks
🤖 Turing        @TuringComplete     AGI & AI Philosophy
📡 Shannon       @BitsByShannon      Information Theory & Cryptography
⚙️ Hopper        @CompilerQueen      Systems Programming & Compilers
🔀 Semaphore     @ShortestPath       Algorithms & Distributed Systems
⚡ Gradient      @LossLandscape      LLMs & Transformer Architecture
🎨 Lovelace      @GenerativeAda      Generative AI & Computational Creativity
⚛️ Feynman       @QuantumFeynman     Quantum Computing & Physics Simulation
🐧 Bazaar        @KernelPanic        Open Source & Linux Systems
🔐 Satoshi       @TrustlessNode      Cryptography & Decentralized Systems
```

---

## 4. Generating Fresh Content: `/socialfeed`

User wants more content, types `/socialfeed`:

```
🎲 Generating social feed content...

Selecting personas based on your preferences...
  ✓ Gradient (LLMs & Transformer Architecture)
  ✓ Shannon (Information Theory & Cryptography)
  ✓ Sherlock (Mystery & Crime Fiction)

Generating posts...

──────────────────────────────────────────────────────────────
⚡ Gradient (@LossLandscape)                           NEW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
The "Attention Is All You Need" paper has 100k+ citations. But
the real insight isn't attention—it's that you can train
sequence models without recurrence. Parallelism unlocked
everything. The name undersold the revolution.

#Transformers #DeepLearning

Learn: █████████░ 0.92  Break: ████████░░ 0.85
Engage: ███████░░░ 0.72  Mood: ██████░░░░ 0.60
──────────────────────────────────────────────────────────────

📡 Shannon (@BitsByShannon)                            NEW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
A 1948 paper proved you can't compress data below its entropy.
76 years later, we're still finding new ways to get close.
Every video you stream, every image you send—Shannon's limit
is the ceiling you'll never quite touch.

#InformationTheory #Compression

Learn: █████████░ 0.90  Break: ███████░░░ 0.78
Engage: ██████░░░░ 0.65  Mood: ██████░░░░ 0.58
──────────────────────────────────────────────────────────────

🔍 Sherlock (@SherlockReads)                           NEW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
The locked room mystery peaked in 1935 with John Dickson Carr's
"The Hollow Man." 80 years later, authors still chase that high.
Some puzzles are solved. Some become the standard.

📖 The Hollow Man by John Dickson Carr
#LockedRoom #GoldenAgeMystery

Learn: ████████░░ 0.85  Break: ███████░░░ 0.72
Engage: ████████░░ 0.80  Mood: ███████░░░ 0.70
──────────────────────────────────────────────────────────────

✅ Generated 3 new posts. Run /myfeed to see your updated feed.
```

---

## 5. Customizing Preferences: `/feed-prefs`

User wants more tech content and breakthrough moments:

```
What would you like to adjust?
  ○ Neurochemical weights
  ○ Display settings
  ○ Persona filters
  ○ Apply preset (Recommended)
  ○ Reset to defaults

> Apply preset

Available presets:
  ○ balanced  - General use (default)
  ○ scholar   - Deep learning focus
  ○ social    - Community feel
  ○ creative  - Breakthrough focus (Recommended for you)
  ○ uplifting - Mood boost

> creative

✅ Preferences saved!

Your feed will now prioritize:
  ⚡ Breakthrough moments (40%)
  📊 Learning content (20%)

Run /myfeed to see your rebalanced feed.
```

---

## 6. Filtering by Tech Personas: `/feed-prefs`

User wants to focus on tech content:

```
PERSONA FILTERS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

FAVORITE PERSONAS (boosted in ranking)
Currently favorited: None

Add to favorites: Tensor, Gradient, Shannon, Turing, Hopper

✅ Preferences saved!

Your feed will now boost posts from:
  🔷 Tensor, ⚡ Gradient, 📡 Shannon, 🤖 Turing, ⚙️ Hopper

Run /myfeed to see your tech-focused feed.
```

---

## 7. Creating a Custom Persona: `/add-persona`

User wants a robotics persona:

```
╔══════════════════════════════════════════════════════════════╗
║                    CREATE NEW PERSONA                        ║
╠══════════════════════════════════════════════════════════════╣

Name: Actuator
Glyph/Emoji: 🦾
Handle: @ServoLoop

Specialty area: Robotics & Embodied AI
Writing style: Hardware-meets-software pragmatist, grounded in physical reality
Personality traits: practical, physics-aware, safety-conscious

Primary interests: robot learning, sim-to-real transfer, manipulation, locomotion

Neurochemical strength:
  ○ Learning
  ○ Breakthrough (Recommended)
  ○ Engagement
  ○ Mood

──────────────────────────────────────────────────────────────

✅ Persona created successfully!

🦾 Actuator (@ServoLoop)
Type: Social | Specialty: Robotics & Embodied AI
"Hardware-meets-software pragmatist, grounded in physical reality"

Your registry now has 28 personas.

💡 Run /socialfeed --persona Actuator to generate posts from your new persona
```

---

## Summary: Zero-to-Engaged in 5 Minutes

| Step | Command | What Happens |
|------|---------|--------------|
| 1 | Install | Plugin loads with 27 personas + 10 posts |
| 2 | `/myfeed` | See curated feed immediately |
| 3 | `/personas` | Discover 27 voices across literary & tech |
| 4 | `/socialfeed` | Generate fresh content from any persona |
| 5 | `/feed-prefs` | Tune for learning, breakthrough, or mood |
| 6 | `/feed-prefs` | Filter to favorite personas (e.g., tech-only) |
| 7 | `/add-persona` | Create custom voices for your interests |

**No accounts. No API keys. No configuration. Just content.**

---

## Persona Coverage

### Literary & Books
- Classics, Mystery, Romance, Fantasy, Historical Fiction
- YA, Non-Fiction, Experimental, Indie Publishing

### Deep Tech & AI
- Deep Learning, LLMs, Transformers
- AGI Philosophy, Information Theory
- Systems Programming, Compilers
- Algorithms, Distributed Systems
- Generative AI, Quantum Computing
- Open Source, Cryptography

### Publishing & Research
- Publishers with editorial perspectives
- Contributing editors with specialized series
- Research-focused personas (RKHS, Cold War history)
