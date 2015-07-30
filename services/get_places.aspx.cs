﻿using System;
using System.Web;

public partial class services_get_places : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string callback = Request.QueryString["callback"];
        string types = Request.QueryString["types"];
        string set = Request.QueryString["set"];
        string from = Request.QueryString["from"];
        string to = Request.QueryString["to"];
        string minx = Request.QueryString["minx"];
        string miny = Request.QueryString["miny"];
        string maxx = Request.QueryString["maxx"];
        string maxy = Request.QueryString["maxy"];
        string order = Request.QueryString["order"];

        // http://localhost:88/seeyourtravel/services/get_places.aspx?types=restaurant%2Clodging&set=full&from=0&to=10&miny=47.955776&minx=10.096568999999999&maxy=48.055775999999994&maxx=10.196569&callback=abc

        string result = @"/**/" + callback + @"( {
   'html_attributions' : [],
   'next_page_token' : 'CoQC9AAAAJ--wCsNhotf9qf23DPwPDuM5t0iBee4HsyLksTuqiJXod1qyTsxA-XZ_d2E6iQO-KxXwUGi-y0abQc75GxAhM7Owzs_CWPfrLhQDcsCwmeIaVJOkFshdN_ms6p0VDtRy9lsAgSd-8ufJcah9CvY8YXHgS8_ZRE0TgcIQvhZH5C0mysMMtnDqQqWaZwpLKJz0_7vR4sWuqYEm8zDxERsaeHGEokIhbuFh-9c_f9YMsdvW8v-Njmt80tKSuWAuz3XA3m8UdqZTDmkkrMEkUhwgsCtEWWG2htDYuM5Ahm_nL_GimwZ8rfGT5tZ0rcmexo6O5NOALeCmX81OFuyjU8RyVcSEBPnezRjVNBcnYCtnP2p_5caFLQYCq7Ntfyh-Me1MF-8SKiBNgm4',
   'results' : [
      {
         'geometry' : {
            'location' : {
               'lat' : 50.459021, 
               'lng' : 30.490029
            }
         },
         'icon' : 'http://maps.gstatic.com/mapfiles/place_api/icons/lodging-71.png',
         'id' : '7b02a90d6ca08c66a393394f651b342cfa099cf7',
         'name' : 'Business Center Forum',
         'opening_hours' : {
            'open_now' : true,
            'weekday_text' : []
         },
         'photos' : [
            {
               'height' : 500,
               'html_attributions' : [
                  '\u003ca href=\'http://asset1.mapia.ua/assets/photos/000/016/367/photos/large/________.jpg\'\u003eBusiness Center Forum, Kyiv\u003c/a\u003e'
               ],
               'raw_reference' : {
                  'fife_url' : 'http://asset1.mapia.ua/assets/photos/000/016/367/photos/large/________.jpg'
               },
               'width' : 375
            }
         ],
         'place_id' : 'SYT_ChIJN4hjZZeDQUYRomvwjuHwwp8',
         'rating' : 1.1,
         'reference' : 'CoQBfwAAAJct3UQ1FDf7msS62iBHPWdfPQWDJp9fMZZszkYpMC5DY8ROI6tqZxtAgWsghUbGtdfOJzCKTQ3jxHkorv9WrqD1z8HumCvVjTZ3vhbK7KuIkpP2-XgTTelUVLgGVZA-4gpUhHrlofYs1TmiutBjH5-a6DzasnPeTmeYifbEbqDOEhBIKylxdg5tQkU1jvHJLE7TGhRykwoUQN-ppdetuMKoVTaslSTSsw',
         'scope' : 'SeeYourTravel',
         'types' : [ 'lodging', 'point_of_interest', 'establishment' ],
         'vicinity' : 'Lukyanivka, Kyiv'
      }
   ],
   'status' : 'OK'
}
 )";
 
        Response.Cache.SetNoStore();
        Response.Cache.SetNoServerCaching();
        Response.Cache.SetMaxAge(new TimeSpan(0));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.AppendCacheExtension("no-store, must-revalidate");
        Response.AppendHeader("Pragma", "no-cache");
        Response.AppendHeader("Expires", "0");

        Response.ContentType = "application/javascript; charset=utf-8";
        Response.Headers.Add("X-Frame-Options", "SAMEORIGIN");
        Response.Headers.Add("Content-Disposition", "Attachment");

        Response.Write(result);
        
        Response.End();
    }
}