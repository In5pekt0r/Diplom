import 'package:flutter/material.dart';

import '../../../common/route.dart';

class ADSDPartnersScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Partners',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _ADSDPartnersPage(),
    );
  }
}

class _ADSDPartnersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ADSDPartnersPageState();
}

class _ADSDPartnersPageState extends State<_ADSDPartnersPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    // TODO: Add partners fetch
    // load(() => context.read)
  }

  @override
  Widget build(BuildContext context) {
    return _ADSDPartnersPageImpl(data: [
      _ADSDPartnersPagePartnerData(
        title: 'INFO strategic',
        iconName: 'assets/images/InfoStrategic.png',
      ),
      _ADSDPartnersPagePartnerData(
        title: 'Office of the minister of forign affairs and international coorperation',
        iconName: 'assets/images/Office_partner.png',
      ),
      _ADSDPartnersPagePartnerData(
        title: 'Emirates diblomatic academy',
        iconName: 'assets/images/Diplomatic_partner.png',
      ),
      _ADSDPartnersPagePartnerData(
        title: 'Atlantic council',
        iconName: 'assets/images/Council_partner.png',
      ),
      _ADSDPartnersPagePartnerData(
        title: 'Geneva center for security policy (GCSP)',
        iconName: 'assets/images/GSCP_partner.png',
      ),
    ]);
  }
}

class _ADSDPartnersPagePartnerData {
  _ADSDPartnersPagePartnerData({
    required this.title,
    required this.iconName,
  });
  final String title;
  final String iconName;
}

class _ADSDPartnersPageImpl extends StatelessWidget {
  _ADSDPartnersPageImpl({
    required this.data
  });

  final List<_ADSDPartnersPagePartnerData> data;

  Widget listTile(_ADSDPartnersPagePartnerData partner) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 3
          )
        ]
      ),
      child: ListTile(
        title: Text(
          partner.title,
          style: const TextStyle(
            fontSize: 15
          )
        ),
        trailing: Image.asset(
            partner.iconName,
            width: 120
        ),
        minVerticalPadding: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.lightBlue,
              pinned: true,
              expandedHeight: 200,
              toolbarHeight: 0,
              collapsedHeight: 4,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                        Icons.handyman,
                        color: Colors.lightBlue.shade50,
                        size: 180
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const Text(
                                'Partners',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                            Text(
                                'Summary' * 7,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black54
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ];
      },
      body: SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          builder: (context) {
            return CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                      handle: NestedScrollView
                          .sliverOverlapAbsorberHandleFor(context)
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListView.separated(
                              itemCount: data.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (c, i) =>
                              const Divider(
                                  height: 12,
                                  color: Colors.transparent
                              ),
                              itemBuilder: (context, index) {
                                final partner = data.elementAt(index);
                                return listTile(partner);
                              },
                            ),
                          )
                        ]),
                      )
                  )
                ]
            );
          }
        )
      ),
    );
  }
}
