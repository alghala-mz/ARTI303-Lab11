
% Lab 11 - The Name Game

start :-
    menu([a,b,c]).

menu(Letters) :-
    nl,
    writeln('Hi. This is the Name Game.'),
    writeln('Choose from the following:'),
    writeln('1- Display the current set of letters'),
    writeln('2- Add a letter'),
    writeln('3- Add a letter at the top'),
    writeln('4- Add a letter at the bottom'),
    writeln('5- Delete a letter'),
    writeln('6- Delete all letters'),
    writeln('7- Exit'),
    write('Enter your choice: '),
    read(Choice),
    action(Choice, Letters).

% Display letters
action(1, Letters) :-
    write('Current letters: '),
    writeln(Letters),
    menu(Letters).

% Add at a selected position
action(2, Letters) :-
    write('Enter a letter: '),
    read(Letter),
    write('Enter position (starting from 1): '),
    read(Position),
    ( insert_at(Position, Letter, Letters, NewLetters) ->
        writeln('Letter added.'),
        menu(NewLetters)
    ;
        writeln('Invalid position.'),
        menu(Letters)
    ).

% Add at the top
action(3, Letters) :-
    write('Enter a letter: '),
    read(Letter),
    NewLetters = [Letter|Letters],
    writeln('Letter added at the top.'),
    menu(NewLetters).

% Add at the bottom
action(4, Letters) :-
    write('Enter a letter: '),
    read(Letter),
    append(Letters, [Letter], NewLetters),
    writeln('Letter added at the bottom.'),
    menu(NewLetters).

% Delete one letter
action(5, Letters) :-
    write('Enter a letter to delete: '),
    read(Letter),
    ( select(Letter, Letters, NewLetters) ->
        writeln('Letter deleted.'),
        menu(NewLetters)
    ;
        writeln('Letter not found.'),
        menu(Letters)
    ).

% Delete all letters
action(6, _) :-
    writeln('All letters deleted.'),
    menu([]).

% Exit
action(7, _) :-
    writeln('Goodbye!').

% Invalid menu choice
action(_, Letters) :-
    writeln('Invalid choice.'),
    menu(Letters).

% Insert at a specific position
insert_at(Position, Letter, Letters, Result) :-
    integer(Position),
    Position >= 1,
    Index is Position - 1,
    length(Prefix, Index),
    append(Prefix, Suffix, Letters),
    append(Prefix, [Letter|Suffix], Result).
