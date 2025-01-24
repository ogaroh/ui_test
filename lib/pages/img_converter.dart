import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImgConverterPage extends StatefulWidget {
  const ImgConverterPage({super.key, required this.onLanguageChange});

  final Function(Locale) onLanguageChange;

  @override
  State<ImgConverterPage> createState() => _ImgConverterPageState();
}

class _ImgConverterPageState extends State<ImgConverterPage> {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  // show scaffold snackbar
  showSnackbar(
    BuildContext context,
    String text, {
    Color? color,
    IconData? icon,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.removeCurrentSnackBar(reason: SnackBarClosedReason.remove);
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: color ?? Colors.black,
        content: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FaIcon(
                icon ?? Icons.info_outline,
                color: Colors.white,
              ),
            ),
            Expanded(
                child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final cardWidth = width / 2.5;
    const cardHeight = 55;

    BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white.withOpacity(
        _scrollOffset > 100 ? 1.0 : 0.6,
      ),
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.blue, width: 0.5),
    );

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 150.0,
            centerTitle: false,
            pinned: true,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: _scrollOffset > 100 ? 0.0 : 1.0,
              child: Text(
                l10n?.title ?? 'Img Converter',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Colors.black,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  // TODO: Handle select photo action here
                                  showSnackbar(
                                    context,
                                    l10n?.click_here_to_select_photo ??
                                        'Click Here to select photo directly',
                                    color: Colors.blue,
                                    icon: Icons.cloud_upload_outlined,
                                  );
                                },
                                splashColor: Colors.blue.withOpacity(0.5),
                                highlightColor: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  decoration: boxDecoration,
                                  height: 40,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.cloud_upload_outlined,
                                        color: Colors.blue,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              l10n?.select_photo ??
                                                  'Select Photo',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              l10n?.click_here_to_select_photo ??
                                                  'Click Here to select photo directly',
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.blue
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              decoration: boxDecoration,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 40,
                              height: 40,
                              child: InkWell(
                                onTap: () {
                                  // TODO: Handle folder action here
                                  showSnackbar(
                                    context,
                                    l10n?.select_photo ?? 'Select Photo',
                                    color: Colors.blue,
                                    icon: Icons.folder_outlined,
                                  );
                                },
                                splashColor: Colors.blue.withOpacity(0.5),
                                highlightColor: Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                                child: const Icon(
                                  Icons.folder_outlined,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/background.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.3),
                              Colors.white.withOpacity(0.5),
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: _scrollOffset > 100 ? 0.0 : 1.0,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: FaIcon(
                              Icons.card_giftcard_outlined,
                              color: Colors.deepOrange,
                              size: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              l10n?.no_ads ?? 'No Ads',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'en') {
                          widget.onLanguageChange(const Locale('en'));
                        } else if (value == 'zh') {
                          widget.onLanguageChange(const Locale('zh'));
                        }
                      },
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'en',
                          child: Text(
                            'English',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: 'zh',
                          child: Text(
                            '中文',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: cardWidth / cardHeight,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildFileTypeButton(
                        l10n?.jpg ?? 'JPG',
                        FontAwesomeIcons.solidFileImage,
                        Colors.blue,
                      ),
                      _buildFileTypeButton(
                        l10n?.pdf ?? 'PDF',
                        FontAwesomeIcons.solidFilePdf,
                        Colors.red,
                      ),
                      _buildFileTypeButton(
                        l10n?.png ?? 'PNG',
                        FontAwesomeIcons.solidImage,
                        Colors.amber.shade600,
                      ),
                      _buildFileTypeButton(
                        l10n?.gif ?? 'GIF',
                        FontAwesomeIcons.solidFileVideo,
                        Colors.green,
                      ),
                      _buildFileTypeButton(
                        l10n?.webp ?? 'WEBP',
                        FontAwesomeIcons.solidFilePowerpoint,
                        Colors.purple,
                      ),
                      _buildFileTypeButton(
                        l10n?.bmp ?? 'BMP',
                        FontAwesomeIcons.photoFilm,
                        Colors.pink,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Divider(
                  thickness: 8,
                  color: Colors.grey.shade100,
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.solidFolder,
                      color: Colors.amber.shade500,
                      size: 25,
                    ),
                    title: Text(
                      l10n?.my_images ?? 'My Images',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: FaIcon(
                      FontAwesomeIcons.arrowRightLong,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                    onTap: () {
                      // TODO: view my images
                      showSnackbar(
                        context,
                        l10n?.my_images ?? 'My Images',
                        // color: Colors.grey.shade,
                        icon: Icons.folder,
                      );
                    },
                  ),
                ),
                Divider(
                  thickness: 8,
                  color: Colors.grey.shade100,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          l10n?.sponsored ?? 'Sponsored',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.amber.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            l10n?.sponsored ?? 'Sponsored',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileTypeButton(
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        splashColor: color.withOpacity(0.3),
        highlightColor: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          // TODO: open file type
          showSnackbar(
            context,
            label,
            color: color,
            icon: icon,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: FaIcon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
