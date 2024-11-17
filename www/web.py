#coding=utf-8
import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(os.path.dirname(os.path.abspath(__file__)) + '/vendor/')

import asyncio
import tornado
import logging
import time
from setting import settings

class ThreeJSDemoHandler(tornado.web.RequestHandler):
    def get(self,app):
        self.app = app
        self.time_now = time.time()
        self.render("template/threejs/%s.html"%app)

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")

def make_app():
    return tornado.web.Application([
        (r"/threejs/(.*)",ThreeJSDemoHandler),
        (r"/", MainHandler),
    ],**settings)
async def main():
    tornado.options.parse_command_line()
    app = make_app()
    # app.listen(8888)
    app.listen(443,
    ssl_options={
        "certfile": "../server.crt",
        "keyfile": "../server.key",
    })
    await asyncio.Event().wait()


if __name__ == "__main__":
    asyncio.run(main())
