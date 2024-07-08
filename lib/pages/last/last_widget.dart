import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'last_model.dart';
import 'package:gagga/models/institution.dart'; // 필수

export 'last_model.dart';

class LastWidget extends StatefulWidget {
  final List<Institution> filteredInstitutions; // 필터된 학원 리스트

  const LastWidget({Key? key, required this.filteredInstitutions}) : super(key: key);

  @override
  State<LastWidget> createState() => _LastWidgetState();
}

class _LastWidgetState extends State<LastWidget> {
  late LastModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LastModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: true,
          leading: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            icon: Icon(
              Icons.arrow_back_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: ListView.builder(
            itemCount: widget.filteredInstitutions.length,
            itemBuilder: (context, index) {
              final institution = widget.filteredInstitutions[index];
              return Card(
                child: ListTile(
                  title: Text(institution.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Country: ${institution.country}'),
                      Text('Region: ${institution.region}'),
                      Text('Established Year: ${institution.establishedYear}'),
                      Text('Total Students: ${institution.totalStudent}'),
                      Text('Class Size: ${institution.classStudent}'),
                      Text('Activities: ${institution.activity ? "Yes" : "No"}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
