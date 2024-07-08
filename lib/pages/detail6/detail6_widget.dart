import 'package:gagga/models/institution.dart';
import 'package:gagga/utils/filter_institutions.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'detail6_model.dart';
import 'package:gagga/pages/detail7/detail7_widget.dart'; // Make sure this import is correct
export 'detail6_model.dart';

class Detail6Widget extends StatefulWidget {
  final List<Institution> filteredInstitutions;

  const Detail6Widget({Key? key, required this.filteredInstitutions}) : super(key: key);

  @override
  State<Detail6Widget> createState() => _Detail6WidgetState();
}

class _Detail6WidgetState extends State<Detail6Widget> {
  late Detail6Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Detail6Model());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _navigateToNextPage(BuildContext context) {
    List<Institution> filteredInstitutions = filterInstitutionsByTotalStudents(
      widget.filteredInstitutions,
      _model.checkboxGroupValues3 ?? [],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail7Widget(filteredInstitutions: filteredInstitutions),
      ),
    );
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
                              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
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
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
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
                    '5. 어느정도 규모의 어학원을\n원하시나요?',
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
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: FlutterFlowCheckboxGroup(
                      options: ['전체 정원 100명 이하 \n(x<=100)'],
                      onChanged: (val) => setState(() => _model.checkboxGroupValues1 = val),
                      controller: _model.checkboxGroupValueController1 ??=
                          FormFieldController<List<String>>([]),
                      activeColor: FlutterFlowTheme.of(context).primary,
                      checkColor: FlutterFlowTheme.of(context).info,
                      checkboxBorderColor: FlutterFlowTheme.of(context).secondaryText,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                          ),
                      unselectedTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                      checkboxBorderRadius: BorderRadius.circular(4.0),
                      initialized: _model.checkboxGroupValues1 != null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: FlutterFlowCheckboxGroup(
                      options: ['전체정원 200명 정도(100<x<200)'],
                      onChanged: (val) => setState(() => _model.checkboxGroupValues2 = val),
                      controller: _model.checkboxGroupValueController2 ??=
                          FormFieldController<List<String>>([]),
                      activeColor: FlutterFlowTheme.of(context).primary,
                      checkColor: FlutterFlowTheme.of(context).info,
                      checkboxBorderColor: FlutterFlowTheme.of(context).secondaryText,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                          ),
                      unselectedTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                      checkboxBorderRadius: BorderRadius.circular(4.0),
                      initialized: _model.checkboxGroupValues2 != null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: FlutterFlowCheckboxGroup(
                      options: ['전체정원 200명 이상\n(200<=x)'],
                      onChanged: (val) => setState(() => _model.checkboxGroupValues3 = val),
                      controller: _model.checkboxGroupValueController3 ??=
                          FormFieldController<List<String>>([]),
                      activeColor: FlutterFlowTheme.of(context).primary,
                      checkColor: FlutterFlowTheme.of(context).info,
                      checkboxBorderColor: FlutterFlowTheme.of(context).secondaryText,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                          ),
                      unselectedTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                      checkboxBorderRadius: BorderRadius.circular(4.0),
                      initialized: _model.checkboxGroupValues3 != null,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.02, 0.89),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 44.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _navigateToNextPage(context); // 필터링 함수와 페이지 이동 호출
                    },
                    text: '다음으로',
                    options: FFButtonOptions(
                      width: 270.0,
                      height: 50.0,
                      padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFF827AE1),
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
