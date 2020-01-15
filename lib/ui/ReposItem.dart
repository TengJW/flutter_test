import 'package:flutter/material.dart';
import 'package:flutter_app/model/repos_model.dart';
import 'package:flutter_app/ui/webview.dart';

class ReposItem extends StatelessWidget {
  final ReposDataData data;
  final bool isHome;

  const ReposItem(
    this.data, {
    Key key,
    this.isHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        print(data.link);
        Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
          return new MyWebView(
            data.link,
            title: data.title,
          );
        }));
      },
      child: new Container(
        padding: EdgeInsets.all(15),
        height: 150,
        child: new Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: new Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        decorationStyle: TextDecorationStyle.solid),
                  ),
                  new Expanded(
                    flex: 1,
                    child: Text(
                      data.title,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: data.collect ? Colors.red : null,
                      ),
                      Text(
                        data.author,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        data.niceDate,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            new Container(
              width: 72,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10),
              child: new Image.network(
                data.envelopePic,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: new Border(
                bottom: new BorderSide(width: 0.33, color: Color(0xffe5e5e5)))),
      ),
    );
  }
}
