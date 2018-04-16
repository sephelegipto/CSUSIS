<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use app\Services\PeriodSubjectsService;

class PeriodSubjectsServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }

    /**
     * Register the application services.
     *
     * @return void
     */
    public function register()
    {
         $this->app->bind('app\Services\PeriodSubjectsService', function ($app) {
          return new PeriodSubjectsService();
        });
    }
}
