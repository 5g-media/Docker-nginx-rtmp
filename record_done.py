"""
Openwhisk helper action that get called whenever recording file is ready to be consumed

:param path: Path of record file (e.g. tbd)
"""

def main(args):
    path = args.get('path')
    if not path:
        return {'error': 'Missing path'}

    return {'path' : str(path)}
