import 'package:flutter/material.dart';

void main() => runApp(const PokerSocialApp());

const bg = Color(0xFF090516);
const panel = Color(0xFF17102B);
const purple = Color(0xFF7627D8);
const gold = Color(0xFFFFC84A);
const green = Color(0xFF16C76A);
const blue = Color(0xFF13BDF4);

class PokerSocialApp extends StatelessWidget {
  const PokerSocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poker King Social',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: purple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int coins = 1000000;
  int tab = 0;

  String compact(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(n % 1000000 == 0 ? 0 : 1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
    return '$n';
  }

  void open(Widget page) => Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: tab,
          children: [
            _homeBody(),
            TableLobbyScreen(coins: coins, onPlay: (table) => open(PokerTableScreen(table: table))),
            const FriendsScreen(),
            const LeaderboardScreen(period: 'Daily'),
            const ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF100A20),
        indicatorColor: gold.withValues(alpha: .18),
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: gold), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.style_outlined), selectedIcon: Icon(Icons.style, color: gold), label: 'Tables'),
          NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people, color: gold), label: 'Friends'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined), selectedIcon: Icon(Icons.emoji_events, color: gold), label: 'Ranks'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: gold), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _homeBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      children: [
        Row(children: [
          const CircleAvatar(radius: 24, backgroundColor: purple, child: Icon(Icons.person, color: Colors.white, size: 29)),
          const SizedBox(width: 10),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Player', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            SizedBox(height: 3),
            Row(children: [Icon(Icons.star, color: gold, size: 14), SizedBox(width: 4), Text('Level 1', style: TextStyle(color: Colors.white60, fontSize: 12))]),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(28), border: Border.all(color: gold.withValues(alpha: .6))),
            child: Row(children: [const Icon(Icons.monetization_on, color: gold), const SizedBox(width: 5), Text(compact(coins), style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(width: 5), const Icon(Icons.add_circle, color: green)]),
          ),
          const SizedBox(width: 8),
          IconButton(onPressed: () => open(const SettingsScreen()), icon: const Icon(Icons.settings, color: gold)),
        ]),
        const SizedBox(height: 16),
        Container(
          height: 205,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: gold, width: 1.5),
            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF401078), Color(0xFF150A30), Color(0xFF6E1AA7)]),
            boxShadow: [BoxShadow(color: purple.withValues(alpha: .25), blurRadius: 20)],
          ),
          child: Stack(children: [
            const Positioned(right: -2, top: 4, child: Icon(Icons.style, size: 105, color: Color(0x33FFFFFF))),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('WELCOME TO', style: TextStyle(color: gold, fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.bold)),
              const Text('POKER SOCIAL', style: TextStyle(fontSize: 29, height: 1.2, fontWeight: FontWeight.w900, color: Colors.white)),
              const SizedBox(height: 5),
              const Text('PLAY  •  THINK  •  ENJOY', style: TextStyle(color: Colors.white70, letterSpacing: 1.2, fontSize: 11)),
              const Spacer(),
              Row(children: [
                const Icon(Icons.card_giftcard, color: gold),
                const SizedBox(width: 7),
                const Expanded(child: Text('1,000,000 welcome coins', style: TextStyle(fontWeight: FontWeight.bold))),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: const Color(0xFF241200)),
                  onPressed: () => open(const TableLobbyScreen()),
                  child: const Text('LET’S PLAY'),
                ),
              ]),
            ]),
          ]),
        ),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: _FeatureCard(icon: Icons.play_circle_fill, title: 'TEXAS HOLD’EM', subtitle: 'Play at tables', color: const Color(0xFFFF4A23), onTap: () => setState(() => tab = 1))),
          const SizedBox(width: 10),
          Expanded(child: _FeatureCard(icon: Icons.lock, title: 'PRIVATE GAME', subtitle: 'Play with friends', color: purple, onTap: () => open(const PrivateTableScreen()))),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: _FeatureCard(icon: Icons.emoji_events, title: 'DAILY RANKS', subtitle: 'Top today', color: blue, onTap: () => open(const LeaderboardScreen(period: 'Daily')))),
          const SizedBox(width: 10),
          Expanded(child: _FeatureCard(icon: Icons.calendar_month, title: 'WEEKLY RANKS', subtitle: 'Top this week', color: green, onTap: () => open(const LeaderboardScreen(period: 'Weekly')))),
        ]),
        const SizedBox(height: 10),
        _FeatureCard(icon: Icons.workspace_premium, title: 'MONTHLY LEADERBOARD', subtitle: 'Top players this month', color: const Color(0xFFD99A31), onTap: () => open(const LeaderboardScreen(period: 'Monthly'))),
        const SizedBox(height: 14),
        const Text('QUICK REWARDS', style: TextStyle(fontSize: 13, color: gold, letterSpacing: 1.5, fontWeight: FontWeight.w900)),
        const SizedBox(height: 9),
        Row(children: [
          Expanded(child: _SmallAction(icon: Icons.card_giftcard, title: 'Daily Bonus', onTap: () => _message('Daily bonus will be connected to Firebase.'))),
          const SizedBox(width: 8),
          Expanded(child: _SmallAction(icon: Icons.group_add, title: 'Invite Friends', onTap: () => open(const FriendsScreen()))),
          const SizedBox(width: 8),
          Expanded(child: _SmallAction(icon: Icons.monetization_on, title: 'Free Coins', onTap: () => open(FreeCoinsScreen(onReward: () {
            setState(() => coins += 10000);
          })))),
        ]),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: const Color(0xFF211039), borderRadius: BorderRadius.circular(16), border: Border.all(color: purple)),
          child: ListTile(
            leading: const Icon(Icons.ondemand_video, color: green, size: 32),
            title: const Text('Watch Ad & Get 10,000 Coins', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
            subtitle: const Text('Rewarded ads will be connected later', style: TextStyle(fontSize: 11, color: Colors.white60)),
            trailing: const Icon(Icons.chevron_right, color: gold),
            onTap: () => open(FreeCoinsScreen(onReward: () => setState(() => coins += 10000))),
          ),
        ),
        const SizedBox(height: 8),
        const Text('Virtual coins only • No cash value • Prototype', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 10)),
      ],
    );
  }

  void _message(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  const _FeatureCard({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
    color: panel,
    borderRadius: BorderRadius.circular(18),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: color.withValues(alpha: .75))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 11)),
        ]),
      ),
    ),
  );
}

class _SmallAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _SmallAction({required this.icon, required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
      decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(14)),
      child: Column(children: [Icon(icon, color: gold, size: 27), const SizedBox(height: 7), Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))]),
    ),
  );
}

class PokerTableConfig {
  final String name;
  final Color color;
  final String buyIn;
  final String stakes;
  const PokerTableConfig(this.name, this.color, this.buyIn, this.stakes);
}

const tableConfigs = [
  PokerTableConfig('Macao Treasures', Color(0xFFB72D3B), '10K – 100K', '500 / 1K'),
  PokerTableConfig('London Riches', Color(0xFF138EB5), '40K – 500K', '1K / 2K'),
  PokerTableConfig('Atlantic City Empire', Color(0xFF8C36C9), '200K – 1M', '5K / 10K'),
  PokerTableConfig('Monte Carlo Fortune', Color(0xFF09985A), '1M – 5M', '25K / 50K'),
  PokerTableConfig('Las Vegas Oasis', Color(0xFF303FC5), '10M – 50M', '250K / 500K'),
  PokerTableConfig('Paris Mystique', Color(0xFF9B4933), 'Not set', 'Not set'),
];

class TableLobbyScreen extends StatelessWidget {
  final int coins;
  final void Function(PokerTableConfig table)? onPlay;
  const TableLobbyScreen({super.key, this.coins = 1000000, this.onPlay});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('TABLE LOBBY'), backgroundColor: bg, actions: [Padding(padding: const EdgeInsets.all(12), child: Center(child: Text('🪙 ${coins.toString()}')))]),
    body: ListView(padding: const EdgeInsets.all(14), children: [
      const Text('Choose your table', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 4),
      const Text('Different stakes • Different colours • Up to 8 players', style: TextStyle(color: Colors.white60, fontSize: 12)),
      const SizedBox(height: 14),
      ...tableConfigs.map((t) => Container(
        margin: const EdgeInsets.only(bottom: 13),
        decoration: BoxDecoration(color: t.color, borderRadius: BorderRadius.circular(24), border: Border.all(color: gold, width: 2), boxShadow: [BoxShadow(color: t.color.withValues(alpha: .22), blurRadius: 12)]),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(children: [
            Text(t.name.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: gold, shadows: [Shadow(color: Colors.black, blurRadius: 4, offset: Offset(1, 2))])),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _TableStat(label: 'BUY-IN', value: t.buyIn)),
              Expanded(child: _TableStat(label: 'STAKE / BLINDS', value: t.stakes)),
            ]),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFF12BEEA), foregroundColor: Colors.white),
              onPressed: () => (onPlay != null) ? onPlay!(t) : Navigator.push(context, MaterialPageRoute(builder: (_) => PokerTableScreen(table: t))),
              child: const Text('PLAY NOW', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
            )),
          ]),
        ),
      )),
      OutlinedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivateTableScreen())), icon: const Icon(Icons.lock), label: const Text('CREATE / JOIN PRIVATE TABLE')),
      const SizedBox(height: 8),
      const Text('Ad banner placement reserved below the table lobby. Ads are not connected yet.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 10)),
    ]),
  );
}

class _TableStat extends StatelessWidget {
  final String label;
  final String value;
  const _TableStat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Column(children: [Text(label, style: const TextStyle(fontSize: 10, color: Colors.white70, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7), decoration: BoxDecoration(color: Colors.black.withValues(alpha: .28), borderRadius: BorderRadius.circular(9)), child: Text(value, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)))]);
}

class PokerTableScreen extends StatelessWidget {
  final PokerTableConfig table;
  const PokerTableScreen({super.key, required this.table});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(table.name)),
    body: Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: [bg, table.color.withValues(alpha: .35), bg], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Center(child: Padding(padding: const EdgeInsets.all(18), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(table.name.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 18),
        Container(
          width: double.infinity, height: 260,
          decoration: BoxDecoration(color: table.color, borderRadius: BorderRadius.circular(150), border: Border.all(color: gold, width: 7)),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('POT', style: TextStyle(color: Colors.white70, letterSpacing: 2)),
            Text('0', style: TextStyle(color: gold, fontSize: 32, fontWeight: FontWeight.w900)),
            SizedBox(height: 15),
            Text('🂡   🂱   🃇   🂠   🂠', style: TextStyle(fontSize: 28)),
            SizedBox(height: 16),
            Text('0 / 8 SEATS OCCUPIED', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ]),
        ),
        const SizedBox(height: 18),
        const Text('Poker engine and real multiplayer will be added next.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 14),
        FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo only — server-side poker actions are not connected yet.'))), child: const Text('JOIN SEAT (DEMO)')),
      ]))),
    ),
  );
}

class PrivateTableScreen extends StatefulWidget {
  const PrivateTableScreen({super.key});
  @override
  State<PrivateTableScreen> createState() => _PrivateTableScreenState();
}
class _PrivateTableScreenState extends State<PrivateTableScreen> {
  final code = TextEditingController();
  @override
  void dispose() { code.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('PRIVATE GAME')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Icon(Icons.lock, color: purple, size: 60),
      const SizedBox(height: 12),
      const Text('Play with friends', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
      const SizedBox(height: 20),
      FilledButton.icon(onPressed: () => _show('Private room creation will be connected to Firebase/server.'), icon: const Icon(Icons.add), label: const Text('CREATE PRIVATE TABLE')),
      const SizedBox(height: 18),
      TextField(controller: code, decoration: const InputDecoration(labelText: 'Room code', border: OutlineInputBorder())),
      const SizedBox(height: 10),
      OutlinedButton(onPressed: () => _show(code.text.trim().isEmpty ? 'Enter a room code first.' : 'Joining by code will be connected to the server.'), child: const Text('JOIN PRIVATE TABLE')),
      const SizedBox(height: 14),
      const Text('Maximum 8 players per table.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white60)),
    ])),
  );
  void _show(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

class FreeCoinsScreen extends StatelessWidget {
  final VoidCallback onReward;
  const FreeCoinsScreen({super.key, required this.onReward});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('FREE COINS')),
    body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.ondemand_video, color: green, size: 70),
      const SizedBox(height: 16),
      const Text('Watch an ad', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
      const SizedBox(height: 8),
      const Text('Reward: 10,000 virtual coins', style: TextStyle(color: gold, fontSize: 17, fontWeight: FontWeight.bold)),
      const SizedBox(height: 14),
      const Text('Prototype only. No ad is playing, so this demo button does not grant coins. Rewarded ads must be integrated and verified before awarding coins.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white60)),
      const SizedBox(height: 18),
      FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rewarded ad integration is a future step. No coins granted in this prototype.'))), child: const Text('WATCH AD')),
    ]))),
  );
}

class LeaderboardScreen extends StatelessWidget {
  final String period;
  const LeaderboardScreen({super.key, this.period = 'Daily'});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('$period Leaderboard')),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      const Icon(Icons.emoji_events, color: gold, size: 65),
      Text('$period Top Earners', textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
      const SizedBox(height: 15),
      ...List.generate(10, (i) => Card(color: panel, child: ListTile(
        leading: CircleAvatar(backgroundColor: i == 0 ? gold : purple, child: Text('${i + 1}', style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white))),
        title: Text(['CardMaster', 'LuckyAce', 'RiverKing', 'ChipWizard', 'RoyalFlush'][i % 5]),
        trailing: Text(i == 0 ? '—' : 'Demo', style: const TextStyle(color: gold, fontWeight: FontWeight.bold)),
      ))),
      const Text('Sample layout only. Real rankings require server-verified coin ledger and time windows.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white38, fontSize: 11)),
    ]),
  );
}

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('FRIENDS')), body: const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('Friends list, invites, and online status will be connected in the next step.', textAlign: TextAlign.center))));
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('PROFILE')), body: const Center(child: Text('Player profile and stats — coming next.')));
}
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('SETTINGS')), body: const ListView(children: [ListTile(leading: Icon(Icons.volume_up), title: Text('Sound')), ListTile(leading: Icon(Icons.language), title: Text('Language')), ListTile(leading: Icon(Icons.privacy_tip), title: Text('Privacy & Terms'))]));
}
