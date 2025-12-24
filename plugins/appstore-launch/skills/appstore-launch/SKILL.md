---
description: Generate App Store launch assets (text, images, screenshots, video scripts) for a macOS, iOS, or iPadOS app
argument-hint: [app_path_or_config] [--images-only] [--text-only]
---

Generate App Store launch assets (text, images, screenshots, video scripts) for a macOS, iOS, or iPadOS app.

## Usage

```
/appstore-launch [app_path_or_config] [--images-only] [--text-only]
```

## Arguments

- `app_path_or_config` (optional): Path to either:
  - An Xcode project directory (will analyze and generate config)
  - A JSON config file (will use directly)
  - If omitted, will prompt interactively for app details
- `--images-only`: Only generate images (icons, screenshots, banners)
- `--text-only`: Only generate text assets (descriptions, keywords, etc.)

## Examples

```
/appstore-launch ~/xcode_projects/MyApp
/appstore-launch ./my_app_config.json
/appstore-launch
```

## What This Skill Does

1. **Analyzes your app** (if given an Xcode project path):
   - Reads Swift source files to understand features
   - Extracts version info from project settings
   - Identifies key views and functionality

2. **Generates App Store text assets** (`appstore_assets/`):
   - `appstore_content.md` - Full description, subtitle, promotional text
   - `appstore_content.json` - Machine-readable version
   - `screenshot_guide.md` - Screenshot scenes with captions
   - `video_storyboard.md` - 30-second app preview script
   - `promotional_variants.json` - Social media posts (Twitter, LinkedIn, Product Hunt)
   - `keywords_analysis.md` - Optimized keywords with suggestions
   - `localization_template.json` - Ready for translation
   - `asset_checklist.md` - Complete launch checklist

3. **Generates App Store images** (`appstore_images/`):
   - `icons/` - App icons at all required sizes (16x16 to 1024x1024)
   - `screenshots/` - Marketing screenshots with text overlays for each device size
   - `banners/` - Social media banners (Twitter, Facebook, LinkedIn, Instagram)

4. **Outputs to**: `{project_dir}/appstore_assets/` and `{project_dir}/appstore_images/`

## Steps

### If given an Xcode project path:

1. First, explore the project to understand its structure:
   - Find Swift files and read key ones (ContentView, App file, feature views)
   - Look for existing AboutView, version info, feature documentation
   - Identify the app's main features and functionality

2. Create a JSON config file from the analysis:
   - App name, version, bundle ID from project settings
   - Features extracted from code and documentation
   - Target audiences inferred from functionality

3. Generate text assets using LLM capabilities:
   - App Store description optimized for ASO
   - Compelling subtitle and promotional text
   - Screenshot captions and video storyboard

4. Generate image assets:
   - App icons at all required resolutions
   - Marketing screenshots with device frames
   - Social media banners

### If given a config file:

Use the provided configuration directly to generate all assets.

### If no arguments:

1. Ask the user for key information:
   - App name and version
   - Platform (macOS, iOS, iPadOS)
   - Key features (3-5)
   - Target audiences (2-3)
   - Pricing model

2. Generate a config and produce all assets

## Config File Schema

If you want to create a config file manually, use this structure:

```json
{
  "name": "App Name",
  "version": "1.0.0",
  "codename": "Optional Release Name",
  "bundle_id": "com.example.appname",
  "developer": "Developer Name",
  "platform": "macOS",

  "primary_category": "Productivity",
  "secondary_category": "Business",
  "age_rating": "4+",
  "price_tier": "Free with In-App Purchases",

  "tagline": "Short marketing tagline",
  "subtitle": "30 character subtitle",
  "description_intro": "Opening paragraph for description",
  "whats_new_intro": "What's new in this version",

  "features": [
    {
      "title": "Feature Name",
      "description": "What this feature does",
      "icon": "sf.symbol.name",
      "marketing_hook": "Why users care",
      "is_premium": false
    }
  ],

  "premium_features": [
    "Premium feature 1",
    "Premium feature 2"
  ],

  "target_audiences": [
    {
      "role": "Audience Name",
      "use_case": "How they use the app",
      "pain_point": "Problem it solves"
    }
  ],

  "min_os_version": "14.0",
  "technologies": ["SwiftUI", "PDFKit", "SwiftData"],
  "keywords": ["keyword1", "keyword2"],

  "support_url": "https://example.com/support",
  "privacy_policy_url": "https://example.com/privacy"
}
```

## Platform Support

- **macOS**: MacBook Pro 16", 14", iMac resolutions
- **iOS**: iPhone 6.7", 6.5", 5.5" resolutions
- **iPadOS**: iPad Pro 12.9", 11" resolutions

## Output

After running, you'll have a complete set of App Store assets:

### Text Assets (`appstore_assets/`)

| File | Purpose |
|------|---------|
| `appstore_content.md` | Human-readable text content |
| `appstore_content.json` | Machine-readable content |
| `screenshot_guide.md` | Screenshot capture guide |
| `screenshot_specs.json` | Resolution requirements |
| `video_storyboard.md` | App preview video script |
| `promotional_variants.json` | Social media posts |
| `keywords_analysis.md` | Keyword optimization |
| `localization_template.json` | Translation template |
| `asset_checklist.md` | Launch checklist |

### Image Assets (`appstore_images/`)

| Directory | Contents |
|-----------|----------|
| `icons/` | App icons: 16x16, 32x32, 64x64, 128x128, 256x256, 512x512, 1024x1024 PNG |
| `screenshots/` | Marketing screenshots at each device resolution with feature overlays |
| `banners/` | Social media banners: Twitter (1200x675), Facebook (1200x630), LinkedIn (1200x627), Instagram (1080x1080) |

## Tips

- Review and customize the generated content before submission
- Use the screenshot guide to capture consistent screenshots
- The video storyboard helps plan your 15-30 second app preview
- Social media posts are ready to copy and customize
