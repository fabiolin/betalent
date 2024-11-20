import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:text_mask/text_mask.dart';

import '../../../../models/employee.dart';
import '../providers/states/home_state.dart';
import '../providers/home_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String route = '/Home';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  List<Employee> employees = [];
  final _selectedIndex = ValueNotifier<int>(0);

  Future<void> _fetchPage(int pageKey) async {
    await ref.read(homeStateNotifier.notifier).getEmployees();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (mounted) {
        await _fetchPage(0);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(homeStateNotifier);

    ref.listen(
      homeStateNotifier.select((value) => value),
      ((previous, next) async {
        if (next.state == HomeConcreteState.failure) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: next.message,
            title: "",
            autoCloseDuration: const Duration(seconds: 4),
            showConfirmBtn: false,
          );
        } else if (next.state == HomeConcreteState.loaded) {
          employees = next.listEmployees;
        }
      }),
    );

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              foregroundColor: Colors.grey.shade700,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffDFDFDF),
                      ),
                      child: const Center(
                        child: Text(
                          'CG',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )),
                  Image.asset('assets/images/notification.png'),
                ],
              )),
          body: notifier.state == HomeConcreteState.loading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xff0500FF)))
              : Center(
                  child: SingleChildScrollView(
                      child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 2,
                  color: Colors.white,
                  child: FractionallySizedBox(
                      widthFactor:
                          MediaQuery.of(context).size.width > 600 ? 0.60 : 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Funcionários',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20))),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  employees = notifier.listEmployees
                                      .where((employee) => employee.name
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Pesquisar',
                                fillColor: const Color(0xffF5F5F5),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(children: [
                                Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Color(0xffDFDFDF),
                                              width: 0.5),
                                          left: BorderSide(
                                              color: Color(0xffDFDFDF),
                                              width: 0.5),
                                          right: BorderSide(
                                              color: Color(0xffDFDFDF),
                                              width: 0.5),
                                        ),
                                        color: Color(0xffEDEFFB),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        )),
                                    child: ListTile(
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, right: 35.0),
                                        leading: const Text('Foto',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16)),
                                        title: const Text('Nome',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16)),
                                        trailing: Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black),
                                          width: 20.0 / 2,
                                          height: 20.0 / 2,
                                        ))),
                                SizedBox(
                                    width: double.infinity,
                                    height: constraints.maxHeight - 200,
                                    child: ListView.builder(
                                        itemCount: employees.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                              color: Colors.white,
                                              margin: const EdgeInsets.all(0),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Color(0xffDFDFDF),
                                                      width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0)),
                                              child: ValueListenableBuilder(
                                                  valueListenable:
                                                      _selectedIndex,
                                                  builder: (context, value, _) {
                                                    return Column(
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () => _selectedIndex
                                                                        .value ==
                                                                    employees[
                                                                            index]
                                                                        .id
                                                                ? _selectedIndex
                                                                    .value = 0
                                                                : _selectedIndex
                                                                        .value =
                                                                    employees[
                                                                            index]
                                                                        .id,
                                                            child: ListTile(
                                                              leading:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        employees[index]
                                                                            .image),
                                                              ),
                                                              title: Text(
                                                                  employees[
                                                                          index]
                                                                      .name),
                                                              trailing: _selectedIndex
                                                                          .value ==
                                                                      employees[
                                                                              index]
                                                                          .id
                                                                  ? Image.asset(
                                                                      'assets/images/chevron-up.png')
                                                                  : Image.asset(
                                                                      'assets/images/chevron-down.png'),
                                                            )),
                                                        _selectedIndex.value ==
                                                                employees[index]
                                                                    .id
                                                            ? Column(
                                                                children: [
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              27),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          const Text(
                                                                            'Cargo',
                                                                            style:
                                                                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                                          ),
                                                                          Text(
                                                                            employees[index].job,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )),
                                                                  const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              27),
                                                                      child:
                                                                          DottedLine(
                                                                        dashGapLength:
                                                                            2,
                                                                        lineThickness:
                                                                            0.5,
                                                                        dashColor:
                                                                            Color(0xffDFDFDF),
                                                                      )),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              27),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          const Text(
                                                                            'Data de admissão',
                                                                            style:
                                                                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                                          ),
                                                                          Text(
                                                                            DateFormat('dd/MM/yyyy').format(employees[index].admissionDate),
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )),
                                                                  const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              27),
                                                                      child:
                                                                          DottedLine(
                                                                        dashGapLength:
                                                                            2,
                                                                        lineThickness:
                                                                            0.5,
                                                                        dashColor:
                                                                            Color(0xffDFDFDF),
                                                                      )),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              27),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          const Text(
                                                                            'Telefone',
                                                                            style:
                                                                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                                          ),
                                                                          Text(
                                                                            TextMask(pallet: '+## (##) #####-###').getMaskedText(employees[index].phone),
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )),
                                                                  const Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              27),
                                                                      child:
                                                                          DottedLine(
                                                                        dashGapLength:
                                                                            2,
                                                                        lineThickness:
                                                                            0.5,
                                                                        dashColor:
                                                                            Color(0xffDFDFDF),
                                                                      )),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                ],
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    );
                                                  }));
                                        }))
                              ])),
                        ],
                      )),
                ))));
    });
  }
}
