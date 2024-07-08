import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gagga/fetch_institutions.dart';
import 'package:gagga/flutter_flow/flutter_flow_checkbox_group.dart';
import 'package:gagga/flutter_flow/flutter_flow_icon_button.dart';
import 'package:gagga/flutter_flow/flutter_flow_model.dart';
import 'package:gagga/flutter_flow/flutter_flow_theme.dart';
import 'package:gagga/flutter_flow/flutter_flow_util.dart';
import 'package:gagga/flutter_flow/flutter_flow_widgets.dart';
import 'package:gagga/flutter_flow/form_field_controller.dart';
import 'package:gagga/models/institution.dart';
import 'package:gagga/pages/detail1/detail1_model.dart';
import 'package:gagga/pages/detail2/detail2_widget.dart';
import 'package:gagga/pages/detail3/detail3_widget.dart';
import 'package:gagga/utils/filter_institutions.dart';

class Detail1Widget extends StatefulWidget {
  const Detail1Widget({super.key});

  @override
  State<Detail1Widget> createState() => _Detail1WidgetState();
}

class _Detail1WidgetState extends State<Detail1Widget> {
  late Detail1Model _model;
  Map<String, dynamic>? institutions;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Detail1Model());
    loadJsonData();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/output.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    setState(() {
      institutions = jsonData.map((key, value) =>
          MapEntry(key, Map<String, dynamic>.from(value as Map)));
    });
  }

  void _navigateToNextPage(BuildContext context) async {
    List<Institution> institutions = await fetchInstitutions();
    print('Fetched Institutions: $institutions');
    
    List<Institution> filteredInstitutions = filterInstitutions(institutions, _model.checkboxGroupValues1!);
    print('Filtered Institutions: $filteredInstitutions');

    if (_model.checkboxGroupValues1 != null &&
        _model.checkboxGroupValues1!.contains('공인 인증 시험 대비')) {
      print('Navigating to Detail2 with filtered institutions');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detail2Widget(filteredInstitutions: filteredInstitutions),
        ),
      );
    } else {
      print('Navigating to Detail3 with filtered institutions');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detail3Widget(filteredInstitutions: filteredInstitutions),
        ),
      );
    }
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
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 0.0, 0.0),
                              child: Container(
                                width: 150.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF81E1D7),
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    '맞춤형 어학원 추천 중',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '1. 어학연수를 가는 목적은?',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 30.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Text(
                      '아래 중 해당되는 것을 모두 골라주세요!    ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Divider(
                    height: 24.0,
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: FlutterFlowCheckboxGroup(
                      options: [
                        '회화 General English',
                        '공인 인증 시험 대비',
                        '비즈니스',
                        '취미반',
                        '대학 입학과정',
                        '정하고 있는 중이에요'
                      ],
                      onChanged: (val) =>
                          setState(() => _model.checkboxGroupValues1 = val),
                      controller: _model.checkboxGroupValueController1 ??=
                          FormFieldController<List<String>>(
                        [],
                      ),
                      activeColor: FlutterFlowTheme.of(context).primary,
                      checkColor: FlutterFlowTheme.of(context).info,
                      checkboxBorderColor:
                          FlutterFlowTheme.of(context).secondaryText,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                              ),
                      unselectedTextStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                      checkboxBorderRadius: BorderRadius.circular(4.0),
                      initialized: _model.checkboxGroupValues1 != null,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.02, 0.89),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 44.0),
                  child: FFButtonWidget(
                    onPressed: () => _navigateToNextPage(context),
                    text: '다음으로',
                    options: FFButtonOptions(
                      width: 270.0,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFF827AE1),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
