import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'detail3_model.dart';
import 'package:gagga/models/institution.dart';  // Institution 모델 임포트
import 'package:gagga/utils/filter_institutions.dart';  // 필터링 함수 임포트
import 'package:gagga/pages/detail4/detail4_widget.dart';  // 다음 페이지 임포트
export 'detail3_model.dart';

class Detail3Widget extends StatefulWidget {
  final List<Institution> filteredInstitutions;

  const Detail3Widget({Key? key, required this.filteredInstitutions}) : super(key: key);

  @override
  State<Detail3Widget> createState() => _Detail3WidgetState();
}

class _Detail3WidgetState extends State<Detail3Widget> {
  late Detail3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Detail3Model());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _navigateToNextPage(BuildContext context) {
    List<Institution> filteredInstitutions = filterInstitutionsByNationality(
      widget.filteredInstitutions,
      _model.checkboxGroupValues1!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail4Widget(filteredInstitutions: filteredInstitutions),
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
                    '2. 클래스에 한국인 비율이\n어떠하길 기대하나요?',
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
                      options: ['없으면 좋겠다. \n(x<5%)'],
                      onChanged: (val) => setState(() => _model.checkboxGroupValues1 = val),
                      controller: _model.checkboxGroupValueController1 ??= FormFieldController<List<String>>([]),
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
                      options: ['그래도 조금은 있었으면 좋겠다\n(5<=x<10)'],
                      onChanged: (val) => setState(() => _model.checkboxGroupValues2 = val),
                      controller: _model.checkboxGroupValueController2 ??= FormFieldController<List<String>>([]),
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
                      options: ['한국인이 있으면 좋다\n(10<=x<25)'],
                      onChanged: (val) => setState(() => _model.checkboxGroupValues3 = val),
                      controller: _model.checkboxGroupValueController3 ??= FormFieldController<List<String>>([]),
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: FlutterFlowCheckboxGroup(
                      options: ['한국인들이 많아야 편하다\n(25<=x)'],
                      onChanged: (val) => setState(() => _model.checkboxGroupValues4 = val),
                      controller: _model.checkboxGroupValueController4 ??= FormFieldController<List<String>>([]),
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
                      initialized: _model.checkboxGroupValues4 != null,
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
