#!/usr/bin/env python
import sys, os

from optparse import OptionParser, OptionGroup
from github import Github

def ParseException(inst):
  ''' Takes out useful information from incoming exceptions'''
  exc_type, exc_obj, exc_tb = sys.exc_info()
  exception_fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
  exception_line = str(exc_tb.tb_lineno) 
  exception_type = str(type(inst))
  exception_desc = str(inst)
  print( "  %s: %s in %s:%s"%(exception_type, 
                exception_desc, 
                exception_fname,  
                exception_line ))

def create_repository(options):
    try: 
        g       = Github(options.user, options.password)
        user    = g.get_user(options.user)
        authed  = g.get_user()
        repo    = authed.create_repo(options.repository)
        msg = "Created repository [%s] for user [%s] "%(options.repository, options.user)
        print msg
    except Exception as inst:
        ParseException(inst)

def delete_repository(options):
    try: 
        g       = Github(options.user, options.password)
        authed  = g.get_user()
        repo    = authed.get_repo(options.repository)
        
        repo.delete()
        msg = "Removed repository [%s] for user [%s] "%(options.repository, options.user)
        print msg
    except Exception as inst:
        ParseException(inst)

if __name__ == '__main__':
    usage = "usage: %prog option1=string option2=bool"
    parser = OptionParser(usage=usage)
    parser.add_option('-r', '--repository',
                type="string",
                action='store',
                default=None,
                help='Provide a valid repository name')
    parser.add_option('-u', '--user',
                type="string",
                action='store',
                default=None,
                help='Provide a valid user name')
    parser.add_option('-p', '--password',
                type="string",
                action='store',
                default=None,
                help='Provide a valid password name')

    operation_parser = OptionGroup(parser, "GitHub Operations",
                "Used for CRUD operations")
    operation_parser.add_option('-c', '--create',
                action="store_true", 
                default=False,
                help='Crate a repository')
    operation_parser.add_option('-d', '--delete',
                action="store_true", 
                default=False,
                help='Delete a repository')
    
    parser.add_option_group(operation_parser)
    (options, args) = parser.parse_args()

    if options.repository is None:
       parser.error("Missing required option: --repository='valid repository name'")
    if options.user is None:
       parser.error("Missing required option: --user='valid user name'")
    if options.password is None:
       parser.error("Missing required option: --password='secret password'")
       
    if options.create:
        create_repository(options)  
    elif options.delete:
        delete_repository(options)
    else:
       parser.error("Missing GitHub operation [--create|--delete]")
        
       