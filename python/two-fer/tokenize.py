
import re

dict = {
    'name': 'Eric',
    'title': "Dev Manager'"
}

def tokenize(tokens, text):
    for token_name in dict:
        text = re.sub('{{' + token_name + '}}', dict[token_name], text)
    return text

print(tokenize(dict, 'Hi my name is {{name}}, and my title is {{title}}'))

def tokenize(tokens, text):
    for token_name in tokens:
        text = re.sub('{{' + token_name + '}}', tokens[token_name], text)
    return text

def get_event_by_id(event_id):
    conn = db.get_db()

    event = conn.execute(
        '''
        SELECT
            e.id,
            e.url_slug,
            e.logo_text,
            e.name,
            e.description,
            e.hero_image_url,
            e.agenda_header
        FROM
            events e
        WHERE
            e.id = ?
        '''
    , (event_id)).fetchall()

    
    event = to_dicts(event)[0]
    tokens = {
        'name': event['name'],        
    }
    event['description'] = tokenize(tokens, event['description'])
    return event

def test_event_field_tokenization(client):
    expected_fields = [
        'agenda_header',
        'description',
        'hero_image_url',
        'id',
        'logo_text',
        'name',
        'talks',
        'url_slug'
    ]
    rv = client.get('/api/events/1')
    json_data = rv.get_json()
    s = ("Test your BBQ skills at the " + json_data['name'] + ". <br>"
    "Mark your calendars below, register now, and we'll see you on <br>"
    "{{start}}!"
    )
    assert json_data['description'] == s