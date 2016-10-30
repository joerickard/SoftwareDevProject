INSERT INTO tbl_user (user_email, user_username, user_password)
VALUES
    ('john@smith.com', 'johnSmith', '498c4017ee14ddc016b19f4193d2846e6ee94e44'),
    ('test@domain.com', 'someUsername', 'f8667ca7015807ca21e1246cd683e65158af211c'),
    ('johnDoe@gmail.com', 'johnny', '862ad340965e65471e07b325e90162b5cebf3f2b'),
    ('warhammer227@gmail.com', 'myName', 'b219b78937b277a65ba8b40f8178d3a81ec32151'),
    ('anotherEmail@gmail.com', 'generic_username', '5233d72bb14c6245b2d4ff6cb371efa3be85a8d3');

INSERT INTO tbl_notes (note_name, note_content, note_creator)
VALUES
    ('Shopping list', 'Bread, milk, eggs', '1'),
    ('HW', 'Math, Enligh', '3'),
    ('Cool links', 'http://google.com', '3'),
    ('Favorite Books', 'The Martian', '2'),
    ('Cool videos', 'http://youtube.com/', '4');

INSERT INTO tbl_events (events_name, event_content, event_creator)
VALUES
    ('Johns Birthday Party', 'My birthday party is gonna be soon!', '1'),
    ('Sunset walk on the beach', 'Walking on the beach on tuesday', '5').
    ('Big shopping trip', 'I have lots to buy tomorrow', '3'),
    ('Coffee Date', 'Gonna grab some coffe later today', '4'),
    ('Hiking', 'Hiking up the flatirons on saturday', '2');
