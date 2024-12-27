import 'package:flutter/material.dart';

/// Entrypoint of the application.
void main() {
  runApp(const MyApp());
}

/// [Widget] building thimport 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Dock(
            items: const [
              Icons.person,
              Icons.message,
              Icons.call,
              Icons.camera,
              Icons.photo,
            ],
            builder: (icon, isHovered) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                constraints: BoxConstraints(
                  minWidth: isHovered ? 64 : 48,
                ),
                height: isHovered ? 64 : 48,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.primaries[
                      icon.hashCode % Colors.primaries.length],
                ),
                child: Center(
                  child: Icon(icon, color: Colors.white, size: isHovered ? 32 : 24),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


class Dock extends StatefulWidget {
  const Dock({
    super.key,
    this.items = const [],
    required this.builder,
  });


  final List<IconData> items;

  
  final Widget Function(IconData, bool isHovered) builder;

  @override
  State<Dock> createState() => _DockState();
}


class _DockState extends State<Dock> {
  
  late final List<IconData> _items = widget.items.toList();

  
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _items
            .asMap()
            .entries
            .map((entry) => _buildDraggableItem(entry.key, entry.value))
            .toList(),
      ),
    );
  }

  
  Widget _buildDraggableItem(int index, IconData item) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hoveredIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          _hoveredIndex = null;
        });
      },
      child: Draggable<IconData>(
        data: item,
        feedback: Material(
          color: Colors.transparent,
          child: widget.builder(item, true),
        ),
        childWhenDragging: const SizedBox.shrink(),
        onDragStarted: () {
          setState(() {
            _hoveredIndex = null;
          });
        },
        onDragCompleted: () {},
        child: DragTarget<IconData>(
          builder: (context, candidateData, rejectedData) {
            final isHovered = _hoveredIndex == index;
            return widget.builder(item, isHovered);
          },
          onWillAccept: (incomingItem) => true,
          onAccept: (incomingItem) {
            setState(() {
              // Rearrange items.
              final oldIndex = _items.indexOf(incomingItem);
              if (oldIndex != index) {
                _items.removeAt(oldIndex);
                _items.insert(index, incomingItem);
              }
            });
          },
        ),
      ),
    );
  }
}
e [MaterialApp].
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Dock(
            items: const [
              Icons.person,
              Icons.message,
              Icons.call,
              Icons.camera,
              Icons.photo,
            ],
            builder: (icon, isHovered) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                constraints: BoxConstraints(
                  minWidth: isHovered ? 64 : 48,
                ),
                height: isHovered ? 64 : 48,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      Colors.primaries[icon.hashCode % Colors.primaries.length],
                ),
                child: Center(
                  child: Icon(icon,
                      color: Colors.white, size: isHovered ? 32 : 24),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Dock of the reorderable and animated [items].
class Dock extends StatefulWidget {
  const Dock({
    super.key,
    this.items = const [],
    required this.builder,
  });

  /// Initial items to put in this [Dock].
  final List<IconData> items;

  /// Builder function with hover feedback.
  final Widget Function(IconData, bool isHovered) builder;

  @override
  State<Dock> createState() => _DockState();
}

/// State of the [Dock] for manipulation and animations.
class _DockState extends State<Dock> {
  /// Items being manipulated.
  late final List<IconData> _items = widget.items.toList();

  /// Currently hovered item.
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _items
            .asMap()
            .entries
            .map((entry) => _buildDraggableItem(entry.key, entry.value))
            .toList(),
      ),
    );
  }

  /// Builds a draggable and animated item for the dock.
  Widget _buildDraggableItem(int index, IconData item) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hoveredIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          _hoveredIndex = null;
        });
      },
      child: Draggable<IconData>(
        data: item,
        feedback: Material(
          color: Colors.transparent,
          child: widget.builder(item, true),
        ),
        childWhenDragging: const SizedBox.shrink(),
        onDragStarted: () {
          setState(() {
            _hoveredIndex = null;
          });
        },
        onDragCompleted: () {},
        child: DragTarget<IconData>(
          builder: (context, candidateData, rejectedData) {
            final isHovered = _hoveredIndex == index;
            return widget.builder(item, isHovered);
          },
          onWillAccept: (incomingItem) => true,
          onAccept: (incomingItem) {
            setState(() {
              // Rearrange items.
              final oldIndex = _items.indexOf(incomingItem);
              if (oldIndex != index) {
                _items.removeAt(oldIndex);
                _items.insert(index, incomingItem);
              }
            });
          },
        ),
      ),
    );
  }
}
