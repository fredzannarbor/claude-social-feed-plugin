# Feature Plans: Agentic Social Feed

## Version Naming System

Using pioneers of social media, alphabetically (like Android's dessert names):

| Version | Pioneer | Contribution |
|---------|---------|--------------|
| 1.2 - **Andreessen** | Marc Andreessen | Mosaic/Netscape, enabled the web |
| 1.3 - **Butterfield** | Stewart Butterfield | Flickr, Slack |
| 1.4 - **Chen** | Steve Chen | YouTube co-founder |
| 1.5 - **Dorsey** | Jack Dorsey | Twitter/X co-founder |
| 1.6 - **Evans** | Evan Williams | Blogger, Twitter, Medium |
| 1.7 - **Fitzpatrick** | Brad Fitzpatrick | LiveJournal |
| 1.8 - **Glass** | Noah Glass | Twitter co-founder (coined the name) |
| 1.9 - **Hurley** | Chad Hurley | YouTube co-founder |
| 2.0 - **Ive** | Jonathan Ive | Apple design (enabled mobile social) |
| 2.1 - **Jobs** | Steve Jobs | iPhone (mobile social revolution) |
| 2.2 - **Karim** | Jawed Karim | YouTube co-founder |
| 2.3 - **Levchin** | Max Levchin | PayPal (enabled social commerce) |
| 2.4 - **Moskovitz** | Dustin Moskovitz | Facebook co-founder, Asana |
| 2.5 - **Newmark** | Craig Newmark | Craigslist |
| 2.6 - **Omidyar** | Pierre Omidyar | eBay |
| 2.7 - **Parker** | Sean Parker | Napster, Facebook |
| 2.8 - **Quora** | Adam D'Angelo | Quora founder |
| 2.9 - **Rose** | Kevin Rose | Digg |
| 3.0 - **Systrom** | Kevin Systrom | Instagram |
| 3.1 - **Thiel** | Peter Thiel | PayPal, Facebook investor |
| 3.2 - **Ulukaya** | Hamdi Ulukaya | Chobani (social enterprise pioneer) |
| 3.3 - **Vaynerchuk** | Gary Vaynerchuk | Social media marketing pioneer |
| 3.4 - **Wales** | Jimmy Wales | Wikipedia |
| 3.5 - **Xu** | Eric Xu | Meituan (Chinese social commerce) |
| 3.6 - **Yang** | Jerry Yang | Yahoo |
| 3.7 - **Zuckerberg** | Mark Zuckerberg | Facebook/Meta |

---

## Feature 1: Improved Feed Paging

### Current State
- `/myfeed --limit N` shows N posts (default: 10)
- No page navigation
- No way to see "page 2" without knowing total count
- No persistent cursor/position

### Proposed Enhancement

#### New Arguments
```
--page N        Jump to page N (1-indexed)
--per-page N    Posts per page (default: 10, max: 50)
--next          Shortcut for next page
--prev          Shortcut for previous page
```

#### Updated Display Format

```
══════════════════════════════════════════════════════════════
                    YOUR PERSONALIZED FEED
                      Page 2 of 7 (67 posts)
══════════════════════════════════════════════════════════════

[... posts 11-20 ...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 Page 2 of 7 | Showing posts 11-20 of 67
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Navigation:
  ◀ Previous: /myfeed --page 1
  ▶ Next:     /myfeed --page 3
  ⏮ First:    /myfeed --page 1
  ⏭ Last:     /myfeed --page 7

💡 Tip: Use --per-page to adjust posts per page
```

#### Implementation Steps

1. **Update `skills/myfeed/prompt.md`**
   - Add new arguments documentation
   - Calculate total pages: `ceil(total_posts / per_page)`
   - Slice posts array for current page
   - Add page header with current position
   - Add navigation footer with commands

2. **Update `preferences.json` schema**
   - Add `display.posts_per_page` (already exists)
   - Add `display.last_page` to remember position (optional)

3. **Edge Cases**
   - Page beyond range → show last page with message
   - Empty feed → show "No posts yet" with `/socialfeed` hint
   - Single page → hide navigation arrows

#### User Experience Flow
```
User: /myfeed                    → Shows page 1
User: /myfeed --page 3           → Jumps to page 3
User: /myfeed --next             → Goes to page 4
User: /myfeed --per-page 5       → Shows 5 per page
User: /myfeed --page 2 --per-page 20 → Page 2 with 20 posts
```

---

## Feature 2: Promote Persona to Public Repository

### Current State
- Personas exist only in user's local `~/.claude-social-feed/personas.json`
- No mechanism to share personas with the community
- Default personas in `data/default-personas.json` are static

### Proposed Enhancement

#### New Command: `/promote-persona`

```
/promote-persona PERSONA_NAME [--preview] [--submit]
```

#### Arguments
```
PERSONA_NAME    The persona_id to promote
--preview       Show what would be submitted (default)
--submit        Generate submission file for PR
--format        Output format: json, markdown, pr (default: pr)
```

#### Workflow

##### Step 1: Preview Submission
```
User: /promote-persona my_custom_persona --preview

══════════════════════════════════════════════════════════════
              PERSONA PROMOTION PREVIEW
══════════════════════════════════════════════════════════════

📋 Persona: My Custom Persona
   ID: my_custom_persona
   Type: social
   Glyph: 🎭
   Handle: @MyCustom

✅ Validation Checklist:
   ✓ Unique persona_id (not in defaults)
   ✓ Unique glyph
   ✓ Unique handle
   ✓ Has required fields (bio, specialty, traits)
   ✓ Appropriate content (no profanity)
   ✓ Neurochemical benefit defined

📝 Submission includes:
   - Full persona definition (JSON)
   - 3 sample posts demonstrating voice
   - Brief rationale for inclusion

Ready to submit? Run: /promote-persona my_custom_persona --submit
```

##### Step 2: Generate Submission
```
User: /promote-persona my_custom_persona --submit

══════════════════════════════════════════════════════════════
              PERSONA SUBMISSION GENERATED
══════════════════════════════════════════════════════════════

📁 Created: ~/.claude-social-feed/submissions/my_custom_persona_submission.json

📋 Submission Contents:
   - persona: Full persona definition
   - sample_posts: 3 example posts
   - metadata: Timestamp, version, submitter notes

🚀 Next Steps:

   1. Review the submission file:
      cat ~/.claude-social-feed/submissions/my_custom_persona_submission.json

   2. Fork the repository:
      https://github.com/[owner]/agentic-social-feed

   3. Add your persona to data/default-personas.json

   4. Create a Pull Request with:
      - Title: "Add persona: [Name]"
      - Description: Include your rationale

💡 Alternatively, open an issue with your submission attached.
```

#### Submission File Format

```json
{
  "_submission": {
    "type": "persona_promotion",
    "version": "1.0",
    "submitted_at": "2025-01-15T10:30:00Z",
    "submitter_notes": ""
  },
  "persona": {
    "persona_id": "my_custom_persona",
    "persona_type": "social",
    "name": "My Custom Persona",
    "glyph": "🎭",
    "handle": "@MyCustom",
    "bio": "Description...",
    "specialty": "Specialty area",
    "personality_traits": ["trait1", "trait2"],
    "interests": ["interest1", "interest2"],
    "writing_style": "Description of voice",
    "neurochemical_benefit": "What this optimizes for",
    "follower_count": 1000,
    "active": true
  },
  "sample_posts": [
    {
      "post_type": "insight_discovery",
      "content": "Sample post demonstrating persona voice...",
      "hashtags": ["relevant", "tags"],
      "book_references": [{"title": "Real Book", "author": "Real Author"}],
      "learning_score": 0.75,
      "engagement_score": 0.80,
      "breakthrough_potential": 0.70,
      "mood_elevation_score": 0.65
    }
  ],
  "validation": {
    "unique_id": true,
    "unique_glyph": true,
    "unique_handle": true,
    "has_required_fields": true,
    "content_appropriate": true
  }
}
```

#### Implementation Steps

1. **Create new skill: `skills/promote-persona/prompt.md`**
   - Load target persona from local registry
   - Validate against default personas (no duplicates)
   - Check required fields and uniqueness
   - Generate sample posts in persona's voice
   - Create submission JSON file

2. **Add validation rules**
   - persona_id: lowercase, underscores, unique
   - glyph: single character/emoji, unique
   - handle: starts with @, unique
   - Required fields: bio, specialty, traits, interests, writing_style, neurochemical_benefit

3. **Create submissions directory**
   - `~/.claude-social-feed/submissions/`
   - One file per submission attempt

4. **Add to README**
   - Document the promotion process
   - Link to contribution guidelines
   - Explain approval criteria

#### Approval Criteria (for maintainers)

- [ ] Persona has unique identity (id, glyph, handle)
- [ ] Bio is substantive (50+ chars)
- [ ] Specialty is clear and distinct from existing personas
- [ ] Personality traits are coherent
- [ ] Writing style is defined and demonstrated in samples
- [ ] Neurochemical benefit aligns with project philosophy
- [ ] Sample posts follow content rules (real books, no misinformation)
- [ ] No offensive or inappropriate content

---

## Implementation Priority

1. **Phase 1: Feed Paging** (simpler, immediate user benefit)
   - Update myfeed prompt
   - Add pagination logic
   - Update preferences schema

2. **Phase 2: Persona Promotion** (enables community growth)
   - Create promote-persona skill
   - Add validation framework
   - Create submission format
   - Update documentation

---

## Questions for User

1. **Paging**: Should we remember the last viewed page between sessions?
2. **Paging**: Keyboard shortcuts in terminal (if supported)?
3. **Promotion**: Should we auto-generate sample posts or require user to provide them?
4. **Promotion**: Direct GitHub integration or file-based submission?
