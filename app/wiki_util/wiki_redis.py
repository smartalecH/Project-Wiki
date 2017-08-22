import redis
import collections

RedisPage = collections.namedtuple('RedisPage', ['id', 'title'])


def get_redis_key(group, key):
    return group + key


class WikiRedis(redis.Redis):
    
    def recent_5_changes(self, group):
        """Get 5 most recent changes"""
        _ids = self.lrange(get_redis_key(group, '_changed_page_ids'), 0, 4)
        _titles = self.lrange(get_redis_key(group, '_changed_page_titles'), 0, 4)

        # Redis values are all bytes, use `decode()` to convert them to strings.
        return [RedisPage(_ids[i].decode(), _titles[i].decode()) 
                for i in range(len(_ids))]
    
    def recent_changes(self, group):
        _ids = self.lrange(get_redis_key(group, '_changed_page_ids'), 0, -1)

        # Redis values are all bytes, use `decode()` to convert them to strings.
        return [_id.decode() for _id in _ids]
    
    def add_changed_page(self, group: str, page_id: str, page_title: str) -> None:
        """Keep a list of ids and titles of recently changed
        page, maximum number 50.
        """
        _ids_key = get_redis_key(group, '_changed_page_ids')
        _titles_key = get_redis_key(group, '_changed_page_titles')
        self.lrem(_ids_key, page_id, 0)
        self.lrem(_titles_key, page_title, 0)
        self.lpush(_ids_key, page_id)
        self.lpush(_titles_key, page_title)
        self.ltrim(_ids_key, 0, 49)
        self.ltrim(_titles_key, 0, 49)
        
    def keypages(self, group):
        _ids = self.lrange(get_redis_key(group, '_keypage_ids'), 0, -1)
        _titles = self.lrange(get_redis_key(group, '_keypage_titles'), 0, -1)
        return [RedisPage(_ids[i].decode(), _titles[i].decode()) 
                for i in range(len(_ids))]
        
    def update_keypages(self, group, ids_and_titles):
        """Keep a list of ids and titles of key page."""

        # Get the key of keypage ids for `group`
        _ids_key = get_redis_key(group, '_keypage_ids')

        # Get the key of keypage titles for `group`
        _titles_key = get_redis_key(group, '_titles_key')

        # Delete old keypage ids and titles, then push new ones.
        self.delete(_ids_key, _titles_key)

        # `i[0]` => keypage id (type: ObjectID)
        # Convert to string before push to redis
        self.rpush(_ids_key, *[str(i[0]) for i in ids_and_titles])
        self.rpush(_titles_key, *[i[1] for i in ids_and_titles])