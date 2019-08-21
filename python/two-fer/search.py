def get_talks_by_query(query):
    conn = db.get_db()

    talks = conn.execute(
        '''
        SELECT
            t.talk_id,
            t.name,
            t.description
        FROM
            talk_search t
        WHERE
            talk_search MATCH '{}'
        '''.format(query)
    , ()).fetchall()

    return to_dicts(talks)

@app.route('/api/search')
def search_talks():
    event_id = request.args.get('event', default=None)
    query = request.args.get('query', default=None)
    talks_searches = get_talks_by_query(query)
    talks = get_talks_by_ids([t['talk_id'] for t in talks_searches])
    return to_json_response(to_payload(talks))

    
CREATE VIRTUAL TABLE talk_search
USING FTS5(talk_id, name, description);



def get_talks_by_query(event_id, query):
    conn = db.get_db()
    print(event_id)
    print(query)
    talks = conn.execute(
        '''
        SELECT
            t.event_id,
            t.talk_id,
            t.name,
            t.description
        FROM
            talk_search t
        WHERE
            talk_search MATCH '{}' and t.event_id = ?
        '''.format(query)
    , (event_id)).fetchall()

    return to_dicts(talks)


    
def test_can_search_talks(client):
    expected_fields = [
        'description',
        'duration',
        'id',
        'name',        
        'start'
    ]

    rv = client.get('/api/search?event=1&query=wing')
    json_data = rv.get_json()

    assert len(json_data) is 2

    for field in expected_fields:
        for talk in json_data:
            assert (field in talk and
                    talk[field] is not u'' and
                    talk[field] is not None)