import 'package:doctors_of_kenya/models/models.dart';
import 'package:doctors_of_kenya/utilities/utilities.dart';
import 'package:doctors_of_kenya/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctors_of_kenya/providers/providers.dart';

class ServiceRetrieval extends StatefulWidget {
  final String type;
  ServiceRetrieval({Key key, @required this.type}) : super(key: key);

  @override
  _ServiceRetrievalState createState() => _ServiceRetrievalState();
}

class _ServiceRetrievalState extends State<ServiceRetrieval> {
  Future retrieveServices;

  @override
  void initState() {
    retrieveServices =
        context.read<DatabaseProvider>().retrieveServices(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: retrieveServices,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return GlobalLoader();

          case ConnectionState.active:

          case ConnectionState.none:
            return GlobalErrorContained(
              errorMessage: '${snapshot.error.toString()}',
            );

          case ConnectionState.done:
            if (snapshot.data.length == 0) {
              String insertion = widget.type + ' services';
              return GlobalErrorContained(
                errorMessage: 'There are no $insertion available',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                FacilityServiceModel serviceModel = snapshot.data[index];
                return ServiceListItem(serviceModel: serviceModel);
              },
            );
        }
        return GlobalLoader();
      },
    );
  }
}

class ServiceListItem extends StatelessWidget {
  final FacilityServiceModel serviceModel;
  ServiceListItem({Key key, @required this.serviceModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String used = serviceModel.facilityPaymentModalities.join(', ');

    return Container(
      decoration: Constants.kBoxDecorationStyle,
      child: ListTile(
        leading: Icon(
          Icons.medical_services,
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          serviceModel.facilityName,
          style: Constants.miniheadlineStyle,
        ),
        subtitle: Text(
          'Payment methods accepted are $used',
          style: Constants.subheadlineStyle,
        ),
      ),
    );
  }
}
