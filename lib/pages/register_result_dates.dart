import 'package:control_c/controller/app_model_controller.dart';
import 'package:control_c/data/db_helper.dart';
import 'package:control_c/helpers/const.dart';
import 'package:control_c/helpers/converter.dart';
import 'package:control_c/helpers/snack_bar.dart';
import 'package:control_c/model/app_model.dart';
import 'package:control_c/pages/register_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RegisterResultDates extends StatefulWidget {
  const RegisterResultDates({Key? key}) : super(key: key);

  @override
  State<RegisterResultDates> createState() => _RegisterResultDatesState();
}

class _RegisterResultDatesState extends State<RegisterResultDates> {
  final _controller = AppModelController(DbHelper());

  @override
  void initState() {
    _initialize();
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFF1ABC9C),
        
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    setState(() {});
  }

  Future _initialize() async {
    await _controller.readAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return <Widget>[
            const PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: SliverAppBar(
                title: Text(registerDates),
                centerTitle: true,
                backgroundColor: Color(0xFF1ABC9C),
              ),
            ),
          ];
        },
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              displacement: 0,
              strokeWidth: 3,
              onRefresh: _initialize,
              child: Column(
                children: [
                  if (_controller.length > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(order),
                        Checkbox(
                          value: _controller.compareList,
                          onChanged: (bool? value) {
                            setState(() {
                              _controller.compareList = value!;
                              _initialize();
                            });
                          },
                          activeColor: const Color(0xFF1ABC9C),
                        ),
                      ],
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _controller.length,
                      itemBuilder: (ctx, index) {
                        final appModel = _controller.items[index];
                        final date = _controller.items[index].date;
                        final liters = _controller.items[index].liters;
                        final values = _controller.items[index].value;
                        if (_controller.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Card(
                          elevation: 2,
                          child: Slidable(
                            startActionPane: ActionPane(
                              extentRatio: 0.25,
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => _onDelete(appModel),
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                ),
                              ],
                            ),
                            child: ExpansionTile(
                              title: Text(date),
                              children: [
                                ListTile(
                                  title: Text(
                                      '${Converter.toFixed2(liters)} $litersString\n$money ${Converter.toFixed2(values)}'),
                                  onTap: () => _onUpdate(appModel),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _onCreate,
        backgroundColor: const Color(0xFF1ABC9C),
      ),
    );
  }

  _onCreate() async {
    await Navigator.of(context).pushNamed('/register');
    _initialize();
  }

  _onUpdate(AppModel appModel) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterData(
          appModel: appModel,
        ),
      ),
    );
    _initialize();
  }

  _onDelete(AppModel appModel) async {
    await _controller.delete(appModel);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBarApp.snackBar(
        text: 'Removido com sucesso',
        action: 'Desfazer',
        actionFunction: () => _onDeleteUndo(appModel),
      ),
    );
    _initialize();
  }

  _onDeleteUndo(AppModel appModel) async {
    await _controller.undo(appModel);
    _initialize();
  }
}
