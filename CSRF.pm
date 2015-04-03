package Dancer2::Plugin::CSRF;
use Dancer2::Plugin;

register check_csrf => sub {
    my $dsl     = shift;
    my $app     = $dsl->app;
    my $request = $app->request;
    my $ret_val = 0;

    if ( $request->is_post ) {
        if ( $request->var( 'csrf' ) && $request->var( 'csrf' ) eq $app->session->read( 'csrf' ) ) {
            $ret_val = 1;
        }
    }
    else {
        # Not a POST, return appropiate status.
        $ret_val = $request->status( 401 );
    }

    return $ret_val;
};

register_plugin;

1;