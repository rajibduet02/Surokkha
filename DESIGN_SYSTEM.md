# Surokkha Flutter — Design System

Aligned with the **Figma / React** design system (see `REACT/theme.css`, `REACT/DESIGN_SYSTEM.md`).  
**Philosophy:** Cinematic dark luxury, protective, premium (high-end fintech/security feel).

---

## Colors (`app_colors.dart`)

| Token | Hex | Usage |
|-------|-----|--------|
| `background` | `#0A0A0F` | Screen background |
| `backgroundSecondary` | `#1A1A22` | Cards, secondary surfaces |
| `foreground` | `#FFFFFF` | Primary text |
| `goldPrimary` | `#D4AF37` | Primary gold |
| `goldSecondary` | `#F6D365` | Light gold (gradients) |
| `mutedForeground` | `#8A8A92` | Secondary/muted text |
| `textSecondary` | `#CFCFCF` | Body secondary |
| `primary` | `#D4AF37` | Buttons, accents |
| `primaryForeground` | `#0A0A0F` | Text on primary |
| `secondary` | `#2A2A32` | Surfaces, muted |
| `destructive` | `#EF4444` | Error, emergency |
| `success` | `#10B981` | Success, evidence |
| `warning` | `#F59E0B` | Warning, child profile |
| `border` | `goldPrimary` 10% | Borders |
| `input` | `white` 5% | Input background |
| `ring` | `goldPrimary` 50% | Focus ring |

---

## Typography (`app_text_styles.dart`)

- **H1:** 28px Bold — hero headlines, main titles  
- **H2:** 22px SemiBold — section headers, card titles  
- **Body:** 16px Regular — main content  
- **Caption:** 13px Medium — labels, metadata  
- **Label:** 16px Medium — form labels, buttons  
- **Button:** 16px SemiBold  

Line height: ~1.5 (body), 1.25 (headlines).

---

## Spacing (`app_spacing.dart`) — 8pt grid

- `spacing1` = 8px  
- `spacing2` = 16px  
- `spacing3` = 24px (standard horizontal padding)  
- `spacing4` = 32px  
- `spacing5` = 40px  
- `spacing6` = 48px  

Use `AppSpacing.screenPaddingHorizontal` (24px) for screen padding.

---

## Border radius (`app_radius.dart`)

- **sm:** 16px — small cards, inputs  
- **md:** 20px — standard cards, primary buttons  
- **lg:** 24px — large cards, modals  
- **xl:** 32px — hero sections  

---

## Shadows (`app_shadows.dart`)

- **sm:** subtle elevation  
- **md:** medium elevation  
- **lg:** high elevation  
- **gold:** gold glow (`AppShadows.gold`)  

---

## Gradients (`app_gradients.dart`)

- **primaryGold:** `goldPrimary` → `goldSecondary` (horizontal) — primary CTA  
- **goldDiagonal:** same colors, diagonal — hero/glow  

---

## Component patterns (from React)

- **Primary button:** `AppGradients.primaryGold`, text `AppColors.primaryForeground`, `AppRadius.md`, `AppShadows.gold`  
- **Secondary button:** `AppColors.backgroundSecondary`, border `AppColors.border`, `AppRadius.md`  
- **Glass card:** `AppColors.card` with opacity, border `AppColors.border`, `AppRadius.md`  
- **Input:** `AppColors.inputBackground`, border `AppColors.border`, focus `AppColors.primary`, `AppRadius.sm`  
- **Container:** max width 430, horizontal padding 24px  

---

## Animations (`app_animations.dart`)

- **short:** 200ms  
- **medium / standard:** 300ms  
- **long:** 500ms  
- **pulseCycle:** 2s (SOS / glow repeat)  

Micro-interactions: tap scale 0.98, hover 1.02; entry opacity 0→1, y 20→0.

---

## Layout

- Max content width: **430px**  
- Horizontal padding: **24px** (`AppSpacing.screenPaddingHorizontal`)  
- Bottom safe area for floating nav: **128px** (`AppSpacing.bottomNavPadding`)  

All theme files live under `lib/app/theme/`. Import as needed; prefer theme over hard-coded values.
