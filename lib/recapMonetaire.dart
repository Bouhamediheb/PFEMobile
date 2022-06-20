import 'package:mobilepfe/RecapEtatWidget.dart';
import 'package:mobilepfe/constant.dart';

import 'package:flutter/material.dart';
import 'package:mobilepfe/modelRaccourcis.dart';
import 'constant.dart';

class RecapEtat extends StatefulWidget {
  const RecapEtat({
    Key? key,
  }) : super(key: key);

  @override
  State<RecapEtat> createState() => _RecapEtatState();
}

class _RecapEtatState extends State<RecapEtat> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: defaultPadding),
        FileInfoCardGridView(
          crossAxisCount: size.width < 650 ? 1 : 2,
          childAspectRatio: size.width < 650 ? 3 : 2,
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listeRaccourcis.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          RecapEtatRacc(info: listeRaccourcisEtat[index]),
    );
  }
}
