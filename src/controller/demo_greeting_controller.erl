-module(demo_greeting_controller, [Req]).
-compile(export_all).

% Raw HTML Action

% JSON Action

% Template Action
hello('GET', []) ->
    {ok, [{greeting, "Hello, world!"}]}.


list('GET', []) ->
    Greetings = boss_db:find(greeting, []),
    {ok, [{greetings, Greetings}]}.

% Create Action
create('GET', []) ->
    ok;
create('POST', []) ->
    GreetingText = Req:post_param("greeting_text"),
    NewGreeting = greeting:new(id, GreetingText),
    {ok, SavedGreeting} = NewGreeting:save(),
    {redirect, [{action, "list"}]}.

% Goodbye Controller
%goodbye('POST', []) ->
%    boss_db:delete(Req:post_param("greeting_id")),
%    {redirect, [{action, "list"}]}.

% Test Message Action
%send_test_message('GET', []) ->
%    TestMessage = "Free at last!",
%    boss_mq:push("test-channel", TestMessage),
%    {output, TestMessage}.

% Pull Greetings Action
%pull('GET', [LastTimestamp]) ->
%    {ok, Timestamp, Greetings} = boss_mq:pull("new-greetings",
%        list_to_integer(LastTimestamp)),
%    {json, [{timestamp, Timestamp}, {greetings, Greetings}]}.

% Live Action
%live('GET', []) ->
%    Greetings = boss_db:find(greeting, []),
%    Timestamp = boss_mq:now("new-greetings"),
%    {ok, [{greetings, Greetings}, {timestamp, Timestamp}]}.
