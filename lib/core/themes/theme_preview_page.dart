import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

/// Theme Preview Page — shows all design tokens visually
class ThemePreviewPage extends StatefulWidget {
  const ThemePreviewPage({super.key});

  @override
  State<ThemePreviewPage> createState() => _ThemePreviewPageState();
}

class _ThemePreviewPageState extends State<ThemePreviewPage>
    with SingleTickerProviderStateMixin {
  bool _switchVal = true;
  bool _checkVal = true;
  double _sliderVal = 0.6;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('🎨 Theme Preview'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: 'Colors'),
            Tab(text: 'Typography'),
            Tab(text: 'Buttons'),
            Tab(text: 'Components'),
            Tab(text: 'Spacing'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.palette_rounded),
        label: const Text('Theme'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ColorsTab(),
          _TypographyTab(),
          _ButtonsTab(),
          _ComponentsTab(
            switchVal: _switchVal,
            checkVal: _checkVal,
            sliderVal: _sliderVal,
            onSwitchChanged: (v) => setState(() => _switchVal = v),
            onCheckChanged: (v) => setState(() => _checkVal = v!),
            onSliderChanged: (v) => setState(() => _sliderVal = v),
          ),
          _SpacingTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// COLORS TAB
// =============================================================================
class _ColorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.base),
      children: [
        _SectionTitle('Primary Blue Family'),
        const SizedBox(height: AppSpacing.sm),
        _ColorRow([
          _ColorChip('primary\n#1565C0', AppColors.primary, light: true),
          _ColorChip('primaryLight\n#42A5F5', AppColors.primaryLight, light: true),
          _ColorChip('primaryLighter\n#BBDEFB', AppColors.primaryLighter),
          _ColorChip('primaryDark\n#0D47A1', AppColors.primaryDark, light: true),
          _ColorChip('container\n#E3F2FD', AppColors.primaryContainer),
        ]),
        const SizedBox(height: AppSpacing.xl),
        _SectionTitle('Accent / CTA — Amber'),
        const SizedBox(height: AppSpacing.sm),
        _ColorRow([
          _ColorChip('accent\n#FF6F00', AppColors.accent, light: true),
          _ColorChip('accentLight\n#FFCA28', AppColors.accentLight),
          _ColorChip('accentContainer\n#FFF8E1', AppColors.accentContainer),
        ]),
        const SizedBox(height: AppSpacing.xl),
        _SectionTitle('Semantic Colors'),
        const SizedBox(height: AppSpacing.sm),
        _ColorRow([
          _ColorChip('success\n#2E7D32', AppColors.success, light: true),
          _ColorChip('successLight\n#66BB6A', AppColors.successLight, light: true),
          _ColorChip('successBG\n#E8F5E9', AppColors.successContainer),
        ]),
        const SizedBox(height: AppSpacing.sm),
        _ColorRow([
          _ColorChip('warning\n#F57F17', AppColors.warning, light: true),
          _ColorChip('warningLight\n#FFCC02', AppColors.warningLight),
          _ColorChip('warningBG\n#FFF9C4', AppColors.warningContainer),
        ]),
        const SizedBox(height: AppSpacing.sm),
        _ColorRow([
          _ColorChip('error\n#C62828', AppColors.error, light: true),
          _ColorChip('errorLight\n#EF5350', AppColors.errorLight, light: true),
          _ColorChip('errorBG\n#FFEBEE', AppColors.errorContainer),
        ]),
        const SizedBox(height: AppSpacing.sm),
        _ColorRow([
          _ColorChip('info\n#00838F', AppColors.info, light: true),
          _ColorChip('infoLight\n#4DD0E1', AppColors.infoLight),
          _ColorChip('infoBG\n#E0F7FA', AppColors.infoContainer),
        ]),
        const SizedBox(height: AppSpacing.xl),
        _SectionTitle('Background & Surface'),
        const SizedBox(height: AppSpacing.sm),
        _ColorRow([
          _ColorChip('background\n#F5F7FA', AppColors.background),
          _ColorChip('bgAlt\n#EEF2F7', AppColors.backgroundAlt),
          _ColorChip('surface\n#FFFFFF', AppColors.surface),
          _ColorChip('surfaceVariant\n#F8FAFC', AppColors.surfaceVariant),
          _ColorChip('surfaceTint\n#E8F1FD', AppColors.surfaceTint),
        ]),
        const SizedBox(height: AppSpacing.xl),
        _SectionTitle('Text Colors'),
        const SizedBox(height: AppSpacing.sm),
        _ColorRow([
          _ColorChip('textPrimary\n#1A1A2E', AppColors.textPrimary, light: true),
          _ColorChip('textSecondary\n#546E7A', AppColors.textSecondary, light: true),
          _ColorChip('textTertiary\n#90A4AE', AppColors.textTertiary, light: true),
          _ColorChip('textDisabled\n#B0BEC5', AppColors.textDisabled),
        ]),
        const SizedBox(height: AppSpacing.xl),
        _SectionTitle('Gradients'),
        const SizedBox(height: AppSpacing.sm),
        _GradientRow(),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow(this.chips);
  final List<Widget> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: chips);
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip(this.label, this.color, {this.light = false});
  final String label;
  final Color color;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppSpacing.borderRadiusMd,
        boxShadow: AppShadows.sm,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppSpacing.radiusMd),
                bottomRight: Radius.circular(AppSpacing.radiusMd),
              ),
            ),
            width: double.infinity,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: light ? Colors.white : AppColors.textPrimary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _GradientChip('Primary\nGradient', AppColors.primaryGradient),
        _GradientChip('Accent\nGradient', AppColors.accentGradient),
        _GradientChip('Background\nGradient', AppColors.backgroundGradient),
        _GradientChip('Card\nGradient', AppColors.cardGradient),
      ],
    );
  }
}

class _GradientChip extends StatelessWidget {
  const _GradientChip(this.label, this.gradient);
  final String label;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 70,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: AppSpacing.borderRadiusMd,
        boxShadow: AppShadows.sm,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// =============================================================================
// TYPOGRAPHY TAB
// =============================================================================
class _TypographyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final styles = [
      ('displayLarge — 57px Bold', AppTextStyles.displayLarge),
      ('displayMedium — 45px Bold', AppTextStyles.displayMedium),
      ('displaySmall — 36px SemiBold', AppTextStyles.displaySmall),
      ('headlineLarge — 32px Bold', AppTextStyles.headlineLarge),
      ('headlineMedium — 28px SemiBold', AppTextStyles.headlineMedium),
      ('headlineSmall — 24px SemiBold', AppTextStyles.headlineSmall),
      ('titleLarge — 22px SemiBold', AppTextStyles.titleLarge),
      ('titleMedium — 18px SemiBold', AppTextStyles.titleMedium),
      ('titleSmall — 14px SemiBold', AppTextStyles.titleSmall),
      ('labelLarge — 16px SemiBold', AppTextStyles.labelLarge),
      ('labelMedium — 13px Medium', AppTextStyles.labelMedium),
      ('labelSmall — 11px Medium', AppTextStyles.labelSmall),
      ('bodyLarge — 16px Regular', AppTextStyles.bodyLarge),
      ('bodyMedium — 14px Regular', AppTextStyles.bodyMedium),
      ('bodySmall — 12px Regular', AppTextStyles.bodySmall),
      ('caption — 11px Regular', AppTextStyles.caption),
    ];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.base),
      children: [
        _SectionTitle('Type Scale'),
        const SizedBox(height: AppSpacing.base),
        ...styles.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(color: AppColors.border),
                boxShadow: AppShadows.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text('Climax', style: s.$2),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      s.$1,
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _SectionTitle('Special Purpose'),
        const SizedBox(height: AppSpacing.base),
        _SpecialStyleCard(
          'AppBar Title',
          'Climax Application',
          AppTextStyles.appBarTitle,
        ),
        _SpecialStyleCard('Button Text', 'Get Started', AppTextStyles.button),
        _SpecialStyleCard('Input Text', 'john@example.com', AppTextStyles.input),
        _SpecialStyleCard('Price', '₹2,499', AppTextStyles.price),
        _SpecialStyleCard('Overline', 'CATEGORY LABEL', AppTextStyles.overline),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

class _SpecialStyleCard extends StatelessWidget {
  const _SpecialStyleCard(this.label, this.sample, this.style);
  final String label;
  final String sample;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.sm,
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(sample, style: style)),
          Expanded(
            flex: 2,
            child: Text(label, style: AppTextStyles.caption),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// BUTTONS TAB
// =============================================================================
class _ButtonsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.base),
      children: [
        _SectionTitle('Elevated / Filled Buttons'),
        const SizedBox(height: AppSpacing.base),
        _ButtonCard(children: [
          ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.rocket_launch_rounded),
            label: const Text('With Icon'),
          ),
          ElevatedButton(onPressed: null, child: const Text('Disabled')),
        ]),
        const SizedBox(height: AppSpacing.base),
        _SectionTitle('Outlined Buttons'),
        const SizedBox(height: AppSpacing.sm),
        _ButtonCard(children: [
          OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Item'),
          ),
          OutlinedButton(onPressed: null, child: const Text('Disabled')),
        ]),
        const SizedBox(height: AppSpacing.base),
        _SectionTitle('Text Buttons'),
        const SizedBox(height: AppSpacing.sm),
        _ButtonCard(children: [
          TextButton(onPressed: () {}, child: const Text('TextButton')),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.info_outline_rounded),
            label: const Text('Learn More'),
          ),
        ]),
        const SizedBox(height: AppSpacing.base),
        _SectionTitle('Accent / CTA Buttons'),
        const SizedBox(height: AppSpacing.sm),
        _ButtonCard(children: [
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: AppSpacing.borderRadiusLg,
              boxShadow: AppShadows.accentButton,
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: const Text('🔥 CTA Button'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: AppSpacing.borderRadiusLg,
              boxShadow: AppShadows.primaryButton,
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: const Text('✨ Primary Glow'),
            ),
          ),
        ]),
        const SizedBox(height: AppSpacing.base),
        _SectionTitle('Icon Buttons'),
        const SizedBox(height: AppSpacing.sm),
        _ButtonCard(children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_rounded),
            color: AppColors.error,
          ),
          IconButton.filled(
            onPressed: () {},
            icon: const Icon(Icons.share_rounded),
          ),
          IconButton.filledTonal(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_rounded),
          ),
          IconButton.outlined(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ]),
        const SizedBox(height: AppSpacing.base),
        _SectionTitle('Chips'),
        const SizedBox(height: AppSpacing.sm),
        _ButtonCard(children: [
          Chip(label: const Text('Flutter')),
          Chip(
            label: const Text('Design'),
            avatar: const Icon(Icons.design_services_rounded, size: 16),
          ),
          FilterChip(
            label: const Text('Selected'),
            selected: true,
            onSelected: (_) {},
          ),
          ActionChip(
            label: const Text('Action'),
            onPressed: () {},
            avatar: const Icon(Icons.bolt_rounded, size: 16),
          ),
        ]),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

class _ButtonCard extends StatelessWidget {
  const _ButtonCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.sm,
      ),
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: children,
      ),
    );
  }
}

// =============================================================================
// COMPONENTS TAB
// =============================================================================
class _ComponentsTab extends StatelessWidget {
  const _ComponentsTab({
    required this.switchVal,
    required this.checkVal,
    required this.sliderVal,
    required this.onSwitchChanged,
    required this.onCheckChanged,
    required this.onSliderChanged,
  });

  final bool switchVal;
  final bool checkVal;
  final double sliderVal;
  final ValueChanged<bool> onSwitchChanged;
  final ValueChanged<bool?> onCheckChanged;
  final ValueChanged<double> onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.base),
      children: [
        // Cards
        _SectionTitle('Cards'),
        const SizedBox(height: AppSpacing.sm),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.base),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Default Card', style: AppTextStyles.titleSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Yeh ek default card hai. Border radius, shadow aur surface color theme se aaya hai.',
                style: AppTextStyles.bodySmall,
              ),
            ]),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: AppSpacing.borderRadiusLg,
            boxShadow: AppShadows.md,
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          ),
          padding: const EdgeInsets.all(AppSpacing.base),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: AppSpacing.borderRadiusMd,
              ),
              child: const Icon(Icons.trending_up_rounded,
                  color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Premium Card', style: AppTextStyles.titleSmall),
                Text('Gradient + boxShadow.md', style: AppTextStyles.bodySmall),
              ]),
            ),
            const Text('↗', style: AppTextStyles.headlineSmall),
          ]),
        ),

        const SizedBox(height: AppSpacing.xl),
        // Inputs
        _SectionTitle('Input Fields'),
        const SizedBox(height: AppSpacing.sm),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'john@example.com',
            prefixIcon: Icon(Icons.email_rounded),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: '••••••••',
            prefixIcon: Icon(Icons.lock_rounded),
            suffixIcon: Icon(Icons.visibility_off_rounded),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Error State',
            errorText: 'Yeh field required hai',
            prefixIcon: Icon(Icons.warning_rounded),
          ),
        ),

        const SizedBox(height: AppSpacing.xl),
        // Toggles
        _SectionTitle('Form Controls'),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppSpacing.borderRadiusLg,
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.sm,
          ),
          child: Column(children: [
            ListTile(
              leading: Switch(value: switchVal, onChanged: onSwitchChanged),
              title: const Text('Switch Control'),
              subtitle: Text(switchVal ? 'Enabled' : 'Disabled',
                  style: AppTextStyles.bodySmall),
            ),
            const Divider(height: 0),
            ListTile(
              leading: Checkbox(value: checkVal, onChanged: onCheckChanged),
              title: const Text('Checkbox Control'),
              subtitle: Text(checkVal ? 'Checked' : 'Unchecked',
                  style: AppTextStyles.bodySmall),
            ),
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: Row(children: [
                const Text('Slider:', style: AppTextStyles.bodyMedium),
                Expanded(
                  child: Slider(
                    value: sliderVal,
                    onChanged: onSliderChanged,
                  ),
                ),
                Text('${(sliderVal * 100).toInt()}%',
                    style: AppTextStyles.labelMedium),
              ]),
            ),
          ]),
        ),

        const SizedBox(height: AppSpacing.xl),
        // Shadows
        _SectionTitle('Shadow Levels'),
        const SizedBox(height: AppSpacing.sm),
        Wrap(spacing: AppSpacing.base, runSpacing: AppSpacing.base, children: [
          _ShadowCard('none', AppShadows.none),
          _ShadowCard('sm', AppShadows.sm),
          _ShadowCard('md', AppShadows.md),
          _ShadowCard('lg', AppShadows.lg),
          _ShadowCard('xl', AppShadows.xl),
        ]),

        const SizedBox(height: AppSpacing.xl),
        // Semantic Banners
        _SectionTitle('Semantic Banners'),
        const SizedBox(height: AppSpacing.sm),
        ...[
          (Icons.check_circle_rounded, 'Success', AppColors.success,
              AppColors.successContainer, 'Action successfully completed!'),
          (Icons.warning_rounded, 'Warning', AppColors.warning,
              AppColors.warningContainer, 'Please review before continuing.'),
          (Icons.error_rounded, 'Error', AppColors.error, AppColors.errorContainer,
              'Something went wrong. Try again.'),
          (Icons.info_rounded, 'Info', AppColors.info, AppColors.infoContainer,
              'Here is some helpful information.'),
        ].map(
          (b) => Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: b.$4,
              borderRadius: AppSpacing.borderRadiusMd,
              border: Border.all(color: b.$3.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Icon(b.$1, color: b.$3, size: AppSpacing.iconLg),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(b.$2,
                      style: AppTextStyles.labelLarge.copyWith(color: b.$3)),
                  Text(b.$5, style: AppTextStyles.bodySmall),
                ]),
              ),
            ]),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

class _ShadowCard extends StatelessWidget {
  const _ShadowCard(this.label, this.shadows);
  final String label;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        boxShadow: shadows,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Text(
        'shadow\n.$label',
        style: AppTextStyles.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}

// =============================================================================
// SPACING TAB
// =============================================================================
class _SpacingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spaces = [
      ('xs', AppSpacing.xs),
      ('sm', AppSpacing.sm),
      ('md', AppSpacing.md),
      ('base', AppSpacing.base),
      ('lg', AppSpacing.lg),
      ('xl', AppSpacing.xl),
      ('xxl', AppSpacing.xxl),
      ('xxxl', AppSpacing.xxxl),
      ('huge', AppSpacing.huge),
    ];

    final radii = [
      ('radiusXs', AppSpacing.radiusXs),
      ('radiusSm', AppSpacing.radiusSm),
      ('radiusMd', AppSpacing.radiusMd),
      ('radiusLg', AppSpacing.radiusLg),
      ('radiusXl', AppSpacing.radiusXl),
      ('radiusXxl', AppSpacing.radiusXxl),
      ('radiusFull', 32.0),
    ];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.base),
      children: [
        _SectionTitle('Spacing Scale (4pt grid)'),
        const SizedBox(height: AppSpacing.base),
        ...spaces.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(children: [
              SizedBox(
                width: 70,
                child: Text(
                  '${s.$1}\n${s.$2.toInt()}pt',
                  style: AppTextStyles.caption,
                ),
              ),
              Container(
                height: 28,
                width: s.$2 * 2.5,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: AppSpacing.borderRadiusXs,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text('${s.$2}px', style: AppTextStyles.labelSmall),
            ]),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _SectionTitle('Border Radius Scale'),
        const SizedBox(height: AppSpacing.base),
        Wrap(
          spacing: AppSpacing.base,
          runSpacing: AppSpacing.base,
          children: radii
              .map(
                (r) => Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius:
                          BorderRadius.all(Radius.circular(r.$2.clamp(0, 35))),
                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(r.$1, style: AppTextStyles.caption, textAlign: TextAlign.center),
                  Text('${r.$2.toInt()}px',
                      style: AppTextStyles.labelSmall, textAlign: TextAlign.center),
                ]),
              )
              .toList(),
        ),
        const SizedBox(height: AppSpacing.xl),
        _SectionTitle('Responsive Info'),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.base),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: AppSpacing.borderRadiusLg,
            border: Border.all(color: AppColors.primaryLighter),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.phone_android_rounded, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text('Mobile', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
              const Spacer(),
              Text('width < 600px', style: AppTextStyles.caption),
            ]),
            const SizedBox(height: AppSpacing.xs),
            Text('Page padding: 16px | Columns: 1', style: AppTextStyles.bodySmall),
            const Divider(height: AppSpacing.base),
            Row(children: [
              const Icon(Icons.tablet_rounded, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text('Tablet', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
              const Spacer(),
              Text('600–1024px', style: AppTextStyles.caption),
            ]),
            const SizedBox(height: AppSpacing.xs),
            Text('Page padding: 40px | Columns: 2', style: AppTextStyles.bodySmall),
            const Divider(height: AppSpacing.base),
            Row(children: [
              const Icon(Icons.laptop_rounded, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text('Desktop', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
              const Spacer(),
              Text('width ≥ 1024px', style: AppTextStyles.caption),
            ]),
            const SizedBox(height: AppSpacing.xs),
            Text('Page padding: 80px | Columns: 3', style: AppTextStyles.bodySmall),
            const Divider(height: AppSpacing.base),
            Row(children: [
              const Icon(Icons.screen_rotation_rounded, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text('Current Screen', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
            ]),
            const SizedBox(height: AppSpacing.xs),
            Builder(
              builder: (ctx) {
                final w = MediaQuery.sizeOf(ctx).width;
                final h = MediaQuery.sizeOf(ctx).height;
                final type = AppSpacing.isMobile(ctx)
                    ? '📱 Mobile'
                    : AppSpacing.isTablet(ctx)
                        ? '📟 Tablet'
                        : '💻 Desktop';
                return Text(
                  '$type  •  ${w.toInt()} × ${h.toInt()}px',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ]),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

// =============================================================================
// SHARED HELPERS
// =============================================================================
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 3,
        height: 18,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: AppSpacing.borderRadiusFull,
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Text(
        title,
        style: AppTextStyles.titleSmall.copyWith(color: AppColors.textSecondary),
      ),
    ]);
  }
}
