import 'dart:io';

class Skill {
  final String folderName;
  final String name;
  final String description;
  final String fullContent;

  Skill({
    required this.folderName,
    required this.name,
    required this.description,
    required this.fullContent,
  });
}

void main(List<String> arguments) {
  final skillsDir = Directory('.agents/skills');

  if (!skillsDir.existsSync()) {
    printError('Error: Workspace customizations root ".agents/skills" not found.');
    printError('Please run the setup first to clone and install the skills.');
    exit(1);
  }

  final skills = loadSkills(skillsDir);
  if (skills.isEmpty) {
    printWarning('No skills found in .agents/skills.');
    exit(0);
  }

  if (arguments.isNotEmpty) {
    final query = arguments.join(' ').trim();
    if (query == '--help' || query == '-h') {
      printUsage();
      exit(0);
    }
    searchAndShow(query, skills);
  } else {
    runInteractiveMenu(skills);
  }
}

void printUsage() {
  print('${ansiBold}${ansiCyan}VerdiTech Skill Chooser${ansiReset}');
  print('Usage:');
  print('  dart run tool/choose_skill.dart             # Start interactive menu');
  print('  dart run tool/choose_skill.dart <query>     # Search for a specific skill');
  print('  dart run tool/choose_skill.dart --help      # Show this help message');
}

List<Skill> loadSkills(Directory skillsDir) {
  final list = <Skill>[];
  try {
    final dirs = skillsDir.listSync().whereType<Directory>();
    for (final dir in dirs) {
      final skillFile = File('${dir.path}/SKILL.md');
      if (skillFile.existsSync()) {
        final content = skillFile.readAsStringSync();
        final skill = parseSkill(dir.path.split(Platform.pathSeparator).last, content);
        if (skill != null) {
          list.add(skill);
        }
      }
    }
  } catch (e) {
    printError('Failed to load skills: $e');
  }
  return list;
}

Skill? parseSkill(String folderName, String content) {
  try {
    final lines = content.split('\n');
    var inFrontmatter = false;
    var name = '';
    var description = '';
    final yamlLines = <String>[];

    for (var line in lines) {
      final trimmed = line.trim();
      if (trimmed == '---') {
        if (!inFrontmatter) {
          inFrontmatter = true;
          continue;
        } else {
          break; // end of frontmatter
        }
      }
      if (inFrontmatter) {
        yamlLines.add(line);
      }
    }

    for (var line in yamlLines) {
      if (line.startsWith('name:')) {
        name = line.substring(5).trim();
      } else if (line.startsWith('description:')) {
        description = line.substring(12).trim();
      }
    }

    if (name.isEmpty) name = folderName;

    return Skill(
      folderName: folderName,
      name: name,
      description: description,
      fullContent: content,
    );
  } catch (e) {
    // Return partial/fallback skill if parsing failed
    return Skill(
      folderName: folderName,
      name: folderName,
      description: 'Custom Flutter skill.',
      fullContent: content,
    );
  }
}

void searchAndShow(String query, List<Skill> skills) {
  final scored = <MapEntry<Skill, int>>[];

  for (final skill in skills) {
    var score = 0;
    final cleanQuery = query.toLowerCase();
    final cleanName = skill.name.toLowerCase();
    final cleanDesc = skill.description.toLowerCase();

    if (cleanName == cleanQuery) {
      score += 100;
    } else if (cleanName.contains(cleanQuery)) {
      score += 40;
    }

    final queryWords = cleanQuery.split(RegExp(r'\s+'));
    for (final word in queryWords) {
      if (word.isEmpty) continue;
      if (cleanName.contains(word)) score += 15;
      if (cleanDesc.contains(word)) score += 5;
    }

    if (score > 0) {
      scored.add(MapEntry(skill, score));
    }
  }

  scored.sort((a, b) => b.value.compareTo(a.value));

  if (scored.isEmpty) {
    printWarning('\nNo matching skills found for "$query".');
    print('\nAvailable skills to choose from:');
    listAllSkills(skills);
    return;
  }

  print('\n${ansiBold}${ansiGreen}Recommended Skill(s) for "$query":${ansiReset}\n');
  for (var i = 0; i < scored.length; i++) {
    final skill = scored[i].key;
    print('${ansiBold}[${i + 1}] ${skill.name}${ansiReset}');
    print('    Folder: .agents/skills/${skill.folderName}');
    print('    Description: ${skill.description}\n');
  }

  if (scored.length == 1) {
    print('To view details, launch interactive mode or view the file:');
    print('file://${Directory.current.absolute.path}/.agents/skills/${scored[0].key.folderName}/SKILL.md\n');
  } else {
    print('Run without arguments to browse interactively.');
  }
}

void listAllSkills(List<Skill> skills) {
  print('');
  for (var i = 0; i < skills.length; i++) {
    final skill = skills[i];
    print('${ansiBold}[${i + 1}] ${skill.name}${ansiReset}');
    print('    Description: ${skill.description}');
  }
  print('');
}

void runInteractiveMenu(List<Skill> skills) {
  while (true) {
    print('\n=========================================');
    print('  ${ansiBold}${ansiGreen}VerdiTech Flutter Skill Chooser${ansiReset}');
    print('=========================================');
    print('1. List all available Flutter skills');
    print('2. Search skills by keyword');
    print('3. Exit');
    stdout.write('Choose an option (1-3): ');
    final choice = stdin.readLineSync()?.trim() ?? '';

    if (choice == '1') {
      browseSkills(skills);
    } else if (choice == '2') {
      stdout.write('Enter search query: ');
      final query = stdin.readLineSync()?.trim() ?? '';
      if (query.isNotEmpty) {
        searchAndShow(query, skills);
      }
    } else if (choice == '3' || choice.toLowerCase() == 'exit') {
      print('Goodbye!');
      break;
    } else {
      printError('Invalid option, please choose 1, 2, or 3.');
    }
  }
}

void browseSkills(List<Skill> skills) {
  while (true) {
    print('\n--- ${ansiBold}Available Flutter Skills${ansiReset} ---');
    for (var i = 0; i < skills.length; i++) {
      print('${ansiBold}${ansiCyan}[${i + 1}]${ansiReset} ${skills[i].name}');
    }
    print('${ansiBold}${ansiCyan}[0]${ansiReset} Back to main menu');
    stdout.write('Select a skill number to view details: ');
    final input = stdin.readLineSync()?.trim() ?? '';
    final index = int.tryParse(input);

    if (index == 0) {
      break;
    } else if (index != null && index > 0 && index <= skills.length) {
      showSkillDetails(skills[index - 1]);
    } else {
      printError('Invalid selection.');
    }
  }
}

void showSkillDetails(Skill skill) {
  print('\n-----------------------------------------');
  print('${ansiBold}${ansiGreen}Skill:${ansiReset} ${skill.name}');
  print('${ansiBold}${ansiGreen}Folder:${ansiReset} .agents/skills/${skill.folderName}');
  print('${ansiBold}${ansiGreen}Description:${ansiReset} ${skill.description}');
  print('-----------------------------------------');

  // Extract first 15 lines of content to give a preview of how to use it
  final lines = skill.fullContent.split('\n');
  print('\n${ansiBold}Instructions Preview:${ansiReset}');
  var count = 0;
  var printContent = false;
  for (var line in lines) {
    if (line.trim() == '---') {
      if (count == 0) {
        count++;
        continue;
      } else {
        printContent = true;
        continue;
      }
    }
    if (printContent) {
      print(line);
      count++;
      if (count > 25) {
        print('... (open the file to view full instructions) ...');
        break;
      }
    }
  }

  print('\nFull path: file://${Directory.current.absolute.path}/.agents/skills/${skill.folderName}/SKILL.md');
  print('Press Enter to go back...');
  stdin.readLineSync();
}

// ANSI Escape Codes for nice formatting
const String ansiReset = '\x1B[0m';
const String ansiBold = '\x1B[1m';
const String ansiRed = '\x1B[31m';
const String ansiGreen = '\x1B[32m';
const String ansiYellow = '\x1B[33m';
const String ansiCyan = '\x1B[36m';

void printError(String message) {
  print('$ansiRed$message$ansiReset');
}

void printWarning(String message) {
  print('$ansiYellow$message$ansiReset');
}
