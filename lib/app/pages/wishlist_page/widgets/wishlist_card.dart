import 'package:flutter/material.dart';
import 'package:grace_product_buyer/app/styles/styles.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * sixteen),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.width * 0.2,
              width: size.width * 0.19,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(size.width * 0.04),
              ),
            ),
            SizedBox(width: size.width * 0.05),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hannan Shea Body Butter'),
                  const Text('Size: 1,200 ml'),
                  SizedBox(
                    height: size.width * ten,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Tsh 20,000'),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove_circle),
                            ),
                            const Text('1'),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_circle),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
