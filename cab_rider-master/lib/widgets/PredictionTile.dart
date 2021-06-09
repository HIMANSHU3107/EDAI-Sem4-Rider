import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/datamodels/address.dart';
import 'package:cab_rider/datamodels/prediction.dart';
import 'package:cab_rider/dataproviders/appdata.dart';
import 'package:cab_rider/globalvariables.dart';
import 'package:cab_rider/helpers/requesthelper.dart';
import 'package:cab_rider/widgets/ProgressDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  PredictionTile({this.prediction});

  void getPlaceDetails(String placeId, context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Please waiitt..',
            ));
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$mapKey';
    var response = await RequestHelper.getRequest(url);
    Navigator.pop(context);
    if (response == 'failed') {
      return;
    }
    if (response['status'] == 'OK') {
      print('response status is okayyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
      Address thisPlace = Address();
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = placeId;
      thisPlace.latitude = response['result']['geometry']['location']['lat'];
      thisPlace.longitude = response['result']['geometry']['location']['lng'];

      Provider.of<AppData>(context, listen: false)
          .updateDestinationAddress(thisPlace);
      print(thisPlace.placeName);
      Navigator.pop(context, 'getDirection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      //padding: EdgeInsets.all(0),
      onPressed: () {
        getPlaceDetails(prediction.placeId, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 8),
            Row(
              children: <Widget>[
                Icon(OMIcons.locationOn, color: BrandColors.colorDimText),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        prediction.mainText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 2),
                      Text(
                        prediction.secondaryText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 12, color: BrandColors.colorDimText),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
