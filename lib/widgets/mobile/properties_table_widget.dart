import '../custom_loader.dart';
import '../../backend/api.dart';
import '../../helpers/helper.dart';
import '../../models/property.dart';
import 'package:flutter/material.dart';
import '../../models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controllers/property_and_document_controller.dart';

class PropertiesTableWidget extends StatefulWidget {
  const PropertiesTableWidget({Key? key}) : super(key: key);

  @override
  PropertiesTableWidgetState createState() => PropertiesTableWidgetState();
}

class PropertiesTableWidgetState extends StateMVC<PropertiesTableWidget> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  PropertiesTableWidgetState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }
  @override
  Widget build(BuildContext context) {
    return con.properties == null
        ? Center(
            heightFactor: hp.height / 160,
            child: CustomLoader(
                sizeFactor: 10,
                duration: const Duration(seconds: 10),
                color: hp.theme.primaryColor,
                loaderType: LoaderType.fadingCircle))
        : (con.properties!.isEmpty
            ? emptyBuilder(context)
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: hp.isTablet
                    ? tableStructure(context)
                    : hp.dimensions.orientation == Orientation.landscape ?  tableStructure(context) :mobiletableStructure(context))

        //  tableStructure(context),
        // )
        );
  }

  Widget emptyBuilder(BuildContext context) {
    log('afdsdfsd');
    var listValue = ['No Properties Found'];
    var list = (listValue)
        .map((item) => TableRow(
                children: [
                  // TableCell(
                  //   verticalAlignment: TableCellVerticalAlignment.middle,
                  //   child: Padding(
                  //     padding:
                  //         const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                  //     child: Text(item.propertytypename,
                  //         style: hp.textTheme.bodyText1),
                  //   ),
                  // ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                      child: Text(item, style: hp.textTheme.bodyMedium),
                    ),
                  ),
                ],
                decoration: const BoxDecoration(
                    color: /*con.documents!.indexOf(item) % 2 == 0
                    ?*/
                        Colors.white /*: Colors.black12*/)))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Table(
          children: list,
          columnWidths: const {
            0: FlexColumnWidth(4),
          },
          textDirection: TextDirection.ltr,
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: const TableBorder(
              top: BorderSide(
                  color: Colors.black26, style: BorderStyle.solid, width: 1),
              left: BorderSide(
                  color: Colors.black26, style: BorderStyle.solid, width: 1),
              right: BorderSide(
                  color: Colors.black26, style: BorderStyle.solid, width: 1),
              bottom: BorderSide(
                  color: Colors.black26, style: BorderStyle.solid, width: 1),
              verticalInside: BorderSide(
                  color: Colors.black26, style: BorderStyle.solid, width: 1),
              horizontalInside: BorderSide.none)),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.waitForProperties();
  }

  @override
  void didUpdateWidget(PropertiesTableWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    con.waitForProperties();
  }

  Widget tableStructure(BuildContext context) {
    final hp = Helper.of(context);

    var list = (con.properties as List<Property>)
        .map((item) => TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                      child: Text(item.address1, style: hp.textTheme.bodyText1),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 15, bottom: 15),
                        child: Text(item.city, style: hp.textTheme.bodyText1)),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 15),
                          child: Text('View Property',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: hp.theme.focusColor)),
                        ),
                        onTap: () {
                          props.value = item;
                          item.onChange();
                          hp.goTo('/property_details', vcb: () {
                            didUpdateWidget(widget);
                          },
                              args: RouteArgument(
                                  id: 0, params: item, content: 'false'));
                        }),
                  )
                ],
                decoration: const BoxDecoration(
                    color: /*con.documents!.indexOf(item) % 2 == 0
                    ?*/
                        Colors.white /*: Colors.black12*/)))
        .toList();
    list.insert(
      0,
      TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('Address', style: hp.textTheme.bodyText1),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('City', style: hp.textTheme.bodyText1),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('Select', style: hp.textTheme.bodyText1),
          ),
        ),
      ], decoration: const BoxDecoration(color: Colors.black26)),
    );
    return Table(
        children: list,
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(4),
        },
        textDirection: TextDirection.ltr,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
            top: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            left: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            right: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            bottom: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            verticalInside: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            horizontalInside: BorderSide.none));
  }

  Widget mobiletableStructure(BuildContext context) {
    final hp = Helper.of(context);

    return Padding(
        padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: con.properties?.length ?? 0,
              itemBuilder: (context, index) {
                var item = con.properties?[index];
                return Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  color: con.properties!.indexOf(item!) % 2 == 0
                      ? Colors.white
                      : Colors.black12.withAlpha(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, bottom: 0),
                        child: Text(item.address1,
                            textAlign: TextAlign.left,
                            style: hp.textTheme.bodyText1),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, bottom: 0),
                        child: Text(item.city,
                            textAlign: TextAlign.left,
                            style: hp.textTheme.bodyText1),
                      ),
                      GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 0),
                            child: Text('View Property',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: hp.theme.focusColor)),
                          ),
                          onTap: () {
                            props.value = item;
                            item.onChange();
                            hp.goTo('/property_details', vcb: () {
                              didUpdateWidget(widget);
                            },
                                args: RouteArgument(
                                    id: 0, params: item, content: 'false'));
                          }),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                var item = con.properties?[index];
                return Container(
                  height: 10,
                  color: con.properties!.indexOf(item!) % 2 == 0
                      ? Colors.white
                      : Colors.black12.withAlpha(20),
                );
              },
            ),
          ),
        ));
  }
}
