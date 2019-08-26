import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:flutter/material.dart';

class ExerciseBottomSheet extends StatelessWidget {
  final Exercise exercise;

  ExerciseBottomSheet({@required this.exercise});

  @override
  Widget build(BuildContext context) {
    final Size media = MediaQuery.of(context).size;
    return Container(
      color: Color(0xFF737373),
      height: media.height * 8 / 9.5,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        child: _buildContent(context, media),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Size media) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 128.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8.0),

            /// Slider button
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 16.0),
                width: 64.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: Color(0xFFDFDFDF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 64.0),

            /// Exercise tag text
            Text(
              'EXERCISES',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF494F55)),
            ),
            SizedBox(height: 24.0),

            /// Exercise title text
            Text(
              exercise.title,
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF494F55)),
            ),
            SizedBox(height: 32.0),

            /// Exercise content text
            Text(
              exercise.content,
              style: TextStyle(fontSize: 22.0, height: 1.2),
            ),
            SizedBox(height: 64.0),
            _buildAttachmentSection()
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentSection() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            /// Attachments text
            Text(
              'ATTACHMENTS',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9AA8AE),
              ),
            ),

            /// Line divider
            Expanded(
              child: Divider(
                color: Colors.grey,
                height: 2.0,
              ),
            )
          ],
        ),
        SizedBox(height: 32.0),
        Row(
          children: <Widget>[
            /// PDF badge
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(4.0)),
              child: Text(
                'PDF',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(width: 16.0),

            /// Attachments file
            GestureDetector(
              onTap: () {},
              child: Text(
                'expanded_form_problem_exercise_1.pdf',
                style: TextStyle(fontSize: 20.0, color: Color(0xFF6D95EE)),
              ),
            )
          ],
        )
      ],
    );
  }
}
